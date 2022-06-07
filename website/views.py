from django.db.models import Avg, Count, Max, Min, Sum
from django.db.models.query_utils import Q
from django.http import HttpRequest
from django.shortcuts import render, redirect
from .forms import LoginForm, RegistrationForm, UpdateAccountInfoForm
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth import authenticate, login, logout
import math


from .models import MaterialParameter, SiteUser, Tag, WallpaperMaterial, WallpapersEntry, Order

ENTRIES_PER_PAGE = 6


def premade(request: HttpRequest):
    try:
        page = int(request.GET.get("page", 0))
        price_from = float(request.GET.get("price_from", 0))
        price_to = float(request.GET.get("price_to", 0))
        full_picture = request.GET.get(
            "filter_full_picture", "false") != "false"
        search = request.GET.get("filter_search", "")
        filter_tags = request.GET.get("filter_tags", "")
    except ValueError:
        page = 0
        price_from = 0
        price_to = 99999999
        full_picture = False
        search = ""
        filter_tags = ""

    filter_tags = [t for t in filter_tags.split(",") if len(t) > 1]

    entries_filtered = WallpapersEntry.objects.filter(
        Q(full_picture=True) | Q(full_picture=full_picture),
        price__gte=price_from,
        price__lte=price_to if price_to > 0 else 999999999999,
    )

    if search != "":
        entries_filtered = entries_filtered.filter(name__contains=search)

    if len(filter_tags) > 0:
        entries_filtered = entries_filtered.filter(tags__tag__in=filter_tags)

    entries_set = set(entries_filtered)

    entries_to_display = list(entries_set)[page * ENTRIES_PER_PAGE:(page*ENTRIES_PER_PAGE)+ENTRIES_PER_PAGE]

    pages_total = int(math.ceil(len(entries_set) / ENTRIES_PER_PAGE))

    if page != 0:
        breadcrumbs.append((f"Стр {page}", f"/premade?page={page}"))

    breadcrumbs = [("Главная", "/")]
    breadcrumbs.append(("Готовые обои", "/premade"))
    return render(request, "wallpaperfactory/store/store.html", {
        "tags": [tag.json() for tag in Tag.objects.all()],
        "entries": [e.json() for e in entries_to_display],
        "materials": [m.json() for m in WallpaperMaterial.objects.all()],
        "breadcrumbs": breadcrumbs,
        "pages_total": pages_total,
        "current_page": page,
        "entries_per_page": ENTRIES_PER_PAGE,
        "current_page_name": "premade",
    })


def entry_details(request: HttpRequest, entry_id: str):
    entry: WallpapersEntry = WallpapersEntry.objects.get(id=entry_id)

    breadcrumbs = [("Главная", "/")]
    breadcrumbs.append(("Готовые обои", "/premade"))
    breadcrumbs.append((entry.name, f"/premade/{entry.id}"))

    return render(request, "wallpaperfactory/store/entry_details.html", {
        "entry": entry.json(),
        "breadcrumbs": breadcrumbs,
        "material_tags": [t.json() for t in MaterialParameter.objects.all()],
        "materials": [m.json() for m in WallpaperMaterial.objects.all()],
    })


def custom(request: HttpRequest):
    breadcrumbs = [("Главная", "/")]
    breadcrumbs.append(("Конструктор", "/custom"))

    return render(request, "wallpaperfactory/custom.html", {
        "breadcrumbs": breadcrumbs,
        "current_page_name": "custom",
    })


def about(request: HttpRequest):
    breadcrumbs = [("Главная", "/")]
    breadcrumbs.append(("О нас", "/about"))

    return render(request, "wallpaperfactory/about.html", {
        "breadcrumbs": breadcrumbs,
        "current_page_name": "about",
    })


def sales(request: HttpRequest):
    breadcrumbs = [("Главная", "/")]
    breadcrumbs.append(("Акции", "/sales"))

    return render(request, "wallpaperfactory/sales.html", {
        "breadcrumbs": breadcrumbs,
        "current_page_name": "sales",
    })


def profile_info(request: HttpRequest):
    if not request.user.is_authenticated:
        return redirect("/login")

    user: SiteUser = request.user
    error = ""
    PROFILE_INFO_URL = "/profile/info"

    if request.method == "POST":
        account_info_form = UpdateAccountInfoForm(request.POST)

        if account_info_form.is_valid():
            username = account_info_form.cleaned_data["username"]
            first_name = account_info_form.cleaned_data["first_name"]
            last_name = account_info_form.cleaned_data["last_name"]
            email = account_info_form.cleaned_data["email"]
            second_name = account_info_form.cleaned_data["second_name"]
            password1 = account_info_form.cleaned_data["password"]
            password2 = account_info_form.cleaned_data["password_repeat"]

            if (password1 or password2) and (password1 != password2):
                request.session["account_info_error"] = "Пароли не совпадают"
                return redirect(PROFILE_INFO_URL)

            if username:
                user.username = username
            if first_name:
                user.first_name = first_name
            if second_name:
                user.second_name = second_name
            if last_name:
                user.last_name = last_name
            if password1:
                user.set_password(password1)
            if email:
                user.email = email
            user.save()

            return redirect(PROFILE_INFO_URL)
        else:
            request.session["account_info_error"] = "Введены некорректные данные"
            return redirect(PROFILE_INFO_URL)

    breadcrumbs = [("Главная", "/")]
    breadcrumbs.append((f"Профиль {user.username}", "/profile"))
    return render(request, "wallpaperfactory/profile/profile_info.html", {
        "breadcrumbs": breadcrumbs,
        "current_page_name": "profile",
        "account_info_form": UpdateAccountInfoForm(),
        "error": error,
        "current_tab_name": "account"
    })


def profile_orders(request: HttpRequest):
    if not request.user.is_authenticated:
        return redirect("/login")

    orders = Order.objects.filter(user_id=request.user.id)

    orders_json = [o.json() for o in orders]


    breadcrumbs = [("Главная", "/")]
    breadcrumbs.append((f"Заказы", "/profile/orders"))
    return render(request, "wallpaperfactory/profile/profile_orders.html", {
        "breadcrumbs": breadcrumbs,
        "current_page_name": "orders",
        "current_tab_name": "orders",
        "orders": orders_json,
    })


def profile_chats(request: HttpRequest):
    if not request.user.is_authenticated:
        return redirect("/login")

    breadcrumbs = [("Главная", "/")]
    breadcrumbs.append((f"Связь с клиентом", "/profile/orders"))
    return render(request, "wallpaperfactory/profile/profile_chats.html", {
        "breadcrumbs": breadcrumbs,
        "current_page_name": "chats",
        "current_tab_name": "chats"
    })


def profile_accounting(request: HttpRequest):
    if not request.user.is_authenticated:
        return redirect("/login")

    breadcrumbs = [("Главная", "/")]
    breadcrumbs.append((f"Учёт финансов", "/profile/accounting"))
    return render(request, "wallpaperfactory/profile/profile_accounting.html", {
        "breadcrumbs": breadcrumbs,
        "current_page_name": "accounting",
        "current_tab_name": "accounting"
    })


def login_view(request: HttpRequest):
    data_is_wrong_str = "data_is_wrong"

    data_is_wrong = int(request.session.get(data_is_wrong_str, 0))

    if request.method == "POST":
        form = LoginForm(request.POST)
        if form.is_valid():
            email = form.cleaned_data["email"]
            password = form.cleaned_data["password"]

            user = authenticate(request, username=email, password=password)

            if user is not None:
                login(request, user)
                return redirect("/")
            else:
                request.session[data_is_wrong_str] = 1


    if data_is_wrong:
        del request.session[data_is_wrong_str]
        request.session.modified = True

    breadcrumbs = [("Главная", "/")]
    breadcrumbs.append(("Вход", "/login"))
    return render(request, "wallpaperfactory/login.html", {
        "breadcrumbs": breadcrumbs,
        "form": LoginForm(),
        "data_is_wrong": data_is_wrong,
        "current_page_name": "login",
    })


def create_order(request: HttpRequest):
    try:
        m_sq_count = int(request.GET["m_sq_count"])
        material_id = int(request.GET["material"])
        entry_id = int(request.GET["entry"])

        material: WallpaperMaterial = WallpaperMaterial.objects.get(id=material_id)
        entry: WallpapersEntry = WallpapersEntry.objects.get(id=entry_id)
    except Exception:
        return redirect("/")

    breadcrumbs = [("Главная", "/")]
    breadcrumbs.append(("Заказ", request.get_full_path()))
    return render(request, "wallpaperfactory/store/order.html", {
        "breadcrumbs": breadcrumbs,
        "order": {
            "m_sq_count": m_sq_count,
            "material": material.json(),
            "entry": entry.json(),
            "price": m_sq_count * material.price
        }
    })


def logout_view(request: HttpRequest):
    logout()
    return redirect("/")


def registration_view(request: HttpRequest):
    data_is_wrong_str = "data_is_wrong"

    data_is_wrong = int(request.session.get(data_is_wrong_str, 0))

    if request.method == "POST":
        form = LoginForm(request.POST)

        if form.is_valid():
            username = form.cleaned_data["username"]
            password = form.cleaned_data["password"]

            user = authenticate(request, username=username, password=password)

            if user is not None:
                login(request, user)
                return redirect("/")
            else:
                request.session[data_is_wrong_str] = 1

    breadcrumbs = [("Главная", "/")]
    breadcrumbs.append(("Регистрация", "/register"))

    if data_is_wrong:
        del request.session[data_is_wrong_str]
        request.session.modified = True

    return render(request, "wallpaperfactory/register.html", {
        "breadcrumbs": breadcrumbs,
        "form": RegistrationForm(),
        "data_is_wrong": data_is_wrong
    })
