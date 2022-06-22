import datetime
import json
import math
import os
from pprint import pprint
from typing import Optional
import traceback
from unicodedata import name

from django.contrib.auth import authenticate, login, logout
from django.db.models import Avg, Count, Max, Min, Sum
from django.db.models.query_utils import Q
from django.http import FileResponse, Http404, HttpRequest, HttpResponseForbidden, JsonResponse
from django.shortcuts import redirect, render
from django.views.decorators.csrf import csrf_exempt
from django.middleware.csrf import get_token
from django.utils import timezone

from .forms import LoginForm, RegistrationForm
from .models import (Income, IncomeType, MaterialParameter, Order, OrderPlace, SiteUser, Tag,
                     WallpaperMaterial, WallpapersEntry)

from .generate_insight import generate_file

from django.conf import settings
from . import utils

ENTRIES_PER_PAGE = 6

ACCOUNTANT_GN = settings.ACCOUNTANT_GROUP_NAME
MANAGER_GN = settings.MANAGER_GROUP_NAME
ACC_MNGR_GNS = [ACCOUNTANT_GN, MANAGER_GN]


class ErrorCodes:
    UNKNOWN_ERROR: int = 0
    NOT_LOGGED_IN: int = 1
    WRONG_INPUT_DATA: int = 2
    LOGIN_ERROR_WRONG_DATA: int = 3
    ACCESS_DENIED: int = 4
    EMAIL_ALREADY_REGISTERED: int = 5
    USERNAME_ALREADY_REGISTERED: int = 6


class APIResponse(JsonResponse):
    def __init__(self, ok: bool, data: dict, error_code: int = None,
                 error_description: Optional[str] = None):
        err = {}
        if error_code is not None:
            err = {"error": {
                "code": error_code,
                "description": error_description or ""}
            }
        super().__init__({
            "success": int(ok),
            **({"response": data} if error_code is None else {}),
            **err
        })


class APIErrorResponse(APIResponse):
    def __init__(self, error_code: int, error_description: Optional[str] = None):
        super().__init__(False, {}, error_code, error_description)


class APISuccessResponse(APIResponse):
    def __init__(self, data: dict = {}):
        super().__init__(True, data, None, None)


def update_user_info(request: HttpRequest):
    """ Обновляет данные пользователя """
    if not request.user.is_authenticated:
        return HttpResponseForbidden()
    err = None
    try:
        data = json.loads(request.body)
        username = data.get("username")
        first_name = data.get("first_name")
        last_name = data.get("last_name")
        email = data.get("email")
        second_name = data.get("second_name")
        password = data.get("password")

        user = request.user

        def validate(val: str, min_len: int, max_len: int) -> bool:
            return val is not None and len(val) >= min_len and len(val) <= max_len

        if validate(username, 3, 16):
            user.username = username
        else:
            err = "Указано некорректное имя пользователя"
        if validate(first_name, 2, 64):
            user.first_name = first_name
        else:
            err = "Указано некорректное имя"
        if validate(second_name, 2, 64):
            user.second_name = second_name
        else:
            err = "Указана некорректная фамилия"
        if validate(last_name, 0, 64):
            user.last_name = last_name
        else:
            err = "Указано некорректное отчество"
        if validate(password, 3, 128):
            user.set_password(password)
        else:
            err = "Указан некорректный пароль"
        if validate(email, 5, 255) and "@" in email and "." in email:
            user.email = email
        else:
            err = "Указана некорректная почта"

        if err is not None:
            return APIErrorResponse(ErrorCodes.WRONG_INPUT_DATA, err)

        user.save()

    except Exception:
        traceback.print_exc()
        return APIErrorResponse(ErrorCodes.UNKNOWN_ERROR, err)


def login_view(request: HttpRequest):
    try:
        data = json.loads(request.body)
        email = data["email"]
        password = data["password"]

        user = authenticate(request, email=email, password=password)

        if user is not None:
            login(request, user)
            return APISuccessResponse({"userdata": user.json(),
                                       "csrf_token": get_token(request)})

        raise ValueError("Wrong credentials")

    except Exception:
        traceback.print_exc()
        return APIErrorResponse(ErrorCodes.UNKNOWN_ERROR)



def register(request: HttpRequest):
    try:
        data = json.loads(request.body)
        email = data["email"].strip().replace(" ", "")
        username = data["username"].strip().replace(" ", "")
        password = data["password"].strip()
        first_name = data["first_name"].strip().replace(" ", "")
        last_name = data["last_name"].strip().replace(" ", "")
        second_name = data["second_name"].strip().replace(" ", "")

        def is_wrong(txt, min_len = 3, max_len = 16):
            if len(txt) < min_len or len(txt) > max_len:
                return True
            return False

        any_wrong = any([
            is_wrong(email, 5, 127),
            is_wrong(password, 6, 32),
            is_wrong(username, 3, 16),
            is_wrong(first_name, 2, 16),
            is_wrong(last_name, 2, 16),
            is_wrong(second_name, 2, 16),
            not "@" in email,
            not "." in email,
        ])

        if SiteUser.objects.filter(email=email).exists():
            return APIErrorResponse(ErrorCodes.EMAIL_ALREADY_REGISTERED)

        if SiteUser.objects.filter(username=username).exists():
            return APIErrorResponse(ErrorCodes.USERNAME_ALREADY_REGISTERED)

        if any_wrong:
            return APIErrorResponse(ErrorCodes.WRONG_INPUT_DATA)

        user: SiteUser = SiteUser.objects.create(
            email=email,
            username=username,
            password=password,
            first_name=first_name,
            last_name=last_name,
            second_name=second_name,
        )
        user.set_password(password)
        user.save()

        login(request, user)

        return APISuccessResponse(user.json())

    except Exception:
        traceback.print_exc()
        return APIErrorResponse(ErrorCodes.UNKNOWN_ERROR)


def make_order(request: HttpRequest):
    """ 
        Регистрирует заказ. В теле запроса должны содержаться следующие данные:
        ```
        {"material_id": <ID_МАТЕРИАЛА>, "entry_id": <ID_ОБОЕВ>,
         "m_sq_count": <КОЛВО_КВАДРАТНЫХ_МЕТРОВ>}
        ```
        из примера ниже. Для заказа требуется авторизация.

        Возвращает
        ```
        {"success": 1, "response": ID_СОЗДАННОГО_ЗАКАЗА}
        ```
        если заказ успешно зарегистрирован, или
        ```
            {"success": 0, "error": 
            {"code": КОД_ОШИБКИ, "description": "ОПИСАНИЕ_ОШИБКИ"}}
        ```
        если произошла ошибка.

        Возможные коды ошибок:
            - 0 - пользователь не авторизирован
            - 1 - некорректные данные на входе (например, заказ на 0
            квадратных метров или какие-либо данные не указаны).

        ```
        ```
    """
    if not request.user.is_authenticated:
        return HttpResponseForbidden()

    try:
        data = json.loads(request.body)

        entry_id = int(data["entry_id"])
        mat_id = int(data["material_id"])
        m_sq_count = float(data["m_sq_count"])
        order_place_id = int(data["order_place_id"])
        first_name = data["first_name"]
        last_name = data["last_name"]
        email = data["email"]
        paymenttype = int(data["paymenttype"])
        if not paymenttype in Order.possible_payment_types():
            raise ValueError("Неправильный тип оплаты: " + paymenttype)

        material: WallpaperMaterial = WallpaperMaterial.objects.get(id=mat_id)
        entry: WallpapersEntry = WallpapersEntry.objects.get(id=entry_id)
        place: OrderPlace = OrderPlace.objects.get(id=order_place_id)

        price = (material.price * m_sq_count) + entry.price

        order = Order.objects.create(
            entry=entry,
            date=datetime.datetime.now(),
            user_id=request.user.id,
            material=material,
            data=json.dumps({"m_sq_count": m_sq_count}),
            status=0,
            paymenttype=paymenttype,
            address=place.address,
            price=price,
            paid=price,
            first_name=first_name,
            last_name=last_name,
            email=email,
        )

        it_id = settings.INCOME_TYPE_SELL_PREMADE_ID
        if entry.custom:
            it_id = settings.INCOME_TYPE_SELL_CUSTOM_ID

        if it_id is not None:
            Income.objects.create(
                order=order,
                income_type=IncomeType.objects.get(id=it_id),
                amount=price,
                date=timezone.now()
            )

        return APISuccessResponse({
            "order_id": order.id
        })
    except:
        traceback.print_exc()
        return APIErrorResponse(ErrorCodes.WRONG_INPUT_DATA)


def get_premade(request: HttpRequest):
    try:
        data = json.loads(request.body)
        page = int(data.get("page", 0))
        price_from = float(data.get("price_from", 0))
        price_to = float(data.get("price_to", 0))
        full_picture = data.get("full_picture", False)
        search = data.get("search", "")
        filter_tags = data.get("tags", [])

        entries_filtered = WallpapersEntry.objects.filter(
            Q(full_picture=True) | Q(full_picture=full_picture),
            price__gte=price_from
        )

        if price_to > 0:
            entries_filtered = entries_filtered.filter(price__lte=price_to)

        if search != "":
            entries_filtered = entries_filtered.filter(name__contains=search)

        if len(filter_tags) > 0:
            entries_filtered = entries_filtered.filter(
                tags__tag__in=filter_tags)

        entries_filtered = entries_filtered.distinct()

        entries_filtered_count = len(entries_filtered)

        entries_to_display = entries_filtered[page *
                                              ENTRIES_PER_PAGE:(page*ENTRIES_PER_PAGE)+ENTRIES_PER_PAGE]

        entries_to_display = list(entries_to_display)

        pages_total = int(math.ceil(entries_filtered_count / ENTRIES_PER_PAGE))
    except Exception:
        traceback.print_exc()
        return APIErrorResponse(ErrorCodes.WRONG_INPUT_DATA)

    return APISuccessResponse(
        {
            "tags": [tag.json() for tag in Tag.objects.all()],
            "entries": [e.json() for e in entries_to_display],
            "pages_total": pages_total,
            "entries_per_page": ENTRIES_PER_PAGE,
        }
    )


def _is_manager(request: HttpRequest) -> bool:
    return request.user.is_authenticated and request.user.groups.filter(name=MANAGER_GN).exists()


def _is_accountant(request: HttpRequest) -> bool:
    return request.user.is_authenticated and request.user.groups.filter(name=ACCOUNTANT_GN).exists()


def _is_acc_or_mngr(request: HttpRequest) -> bool:
    return request.user.is_authenticated and request.user.groups.filter(name__in=[ACCOUNTANT_GN, MANAGER_GN]).exists()


def _get_report_file_path(name: str) -> str:
    return str(settings.REPORTS_FOLDER.joinpath(name))

def _get_reports() -> list[str]:
    return [fn for fn in os.listdir(str(settings.REPORTS_FOLDER))
            if fn.endswith(".xlsx")]


def download_report(request: HttpRequest, name: str):
    if not _is_acc_or_mngr(request):
        return HttpResponseForbidden()

    if name is None:
        return Http404()

    filepath = _get_report_file_path(name)

    if not os.path.exists(filepath):
        return Http404()

    return FileResponse(open(filepath, "rb"))


def get_order_places(request: HttpRequest):
    return APISuccessResponse([p.json() for p in OrderPlace.objects.all()])


def get_reports(request: HttpRequest):
    if not _is_acc_or_mngr(request):
        return APIErrorResponse(ErrorCodes.ACCESS_DENIED)
    return APISuccessResponse(_get_reports())


def create_report(request: HttpRequest):
    if not _is_acc_or_mngr(request):
        return APIErrorResponse(ErrorCodes.ACCESS_DENIED)

    name = datetime.datetime.now().strftime('report-%Y-%m-%d-%H-%M.xlsx')
    generate_file(_get_report_file_path(name))
    return APISuccessResponse(name)


def delete_report(request: HttpRequest):
    if not _is_acc_or_mngr(request):
        return APIErrorResponse(ErrorCodes.ACCESS_DENIED)
    try:
        print(request.body)
        filename = json.loads(request.body)["name"]
        filepath = _get_report_file_path(filename)
        if os.path.exists(filepath):
            os.remove(filepath)
            return APISuccessResponse(_get_reports())
        return APIErrorResponse(ErrorCodes.WRONG_INPUT_DATA)
    except Exception:
        traceback.print_exc()
        return APIErrorResponse(ErrorCodes.UNKNOWN_ERROR)

def get_constructor_image(request: HttpRequest):
    if not request.user.is_authenticated:
        return APIErrorResponse(ErrorCodes.ACCESS_DENIED)
    try:
        h = json.loads(request.body)["hash"]
        f = open(utils.get_constructor_img_file_path_by_hash(h, "rb"))
        return FileResponse(f)
    except Exception:
        traceback.print_exc()
        return APIErrorResponse(ErrorCodes.UNKNOWN_ERROR)


def get_orders(request: HttpRequest):
    if not _is_acc_or_mngr(request):
        return APIErrorResponse(ErrorCodes.ACCESS_DENIED)
    try:
        orders = Order.objects.filter(user_id=request.user.id)
        return APISuccessResponse([o.json() for o in orders])
    except Exception:
        traceback.print_exc()
        return APIErrorResponse(ErrorCodes.UNKNOWN_ERROR)
