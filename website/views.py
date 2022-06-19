from django.db.models import Avg, Count, Max, Min, Sum
from django.db.models.query_utils import Q
from django.http import HttpRequest, HttpResponseForbidden, JsonResponse
from django.shortcuts import render, redirect
from .forms import LoginForm, RegistrationForm
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth import authenticate, login, logout


from .models import MaterialParameter, SiteUser, Tag, WallpaperMaterial, WallpapersEntry, Order


def premade(request: HttpRequest):
    breadcrumbs = [("Главная", "/")]
    breadcrumbs.append(("Готовые обои", "/premade"))
    return render(request, "website/store.html", {
        "breadcrumbs": breadcrumbs,
        "page": {"name": "premade"},
    })


def entry_details(request: HttpRequest, entry_id: str):
    entry: WallpapersEntry = WallpapersEntry.objects.get(id=entry_id)

    breadcrumbs = [("Главная", "/")]
    breadcrumbs.append(("Готовые обои", "/premade"))
    breadcrumbs.append((entry.name, f"/premade/{entry.id}"))

    return render(request, "website/entry_details.html", {
        "entry": entry.json(),
        "breadcrumbs": breadcrumbs,
        "material_tags": [t.json() for t in MaterialParameter.objects.all()],
        "materials": [m.json() for m in WallpaperMaterial.objects.all()],
    })


def iwantcustom(request: HttpRequest):
    breadcrumbs = [("Главная", "/")]
    breadcrumbs.append(("Свой дизайн", "/custom"))
    return render(request, "website/iwantcustom.html", {
        "breadcrumbs": breadcrumbs,
        "page": {"name": "custom"},
    })


def about(request: HttpRequest):
    breadcrumbs = [("Главная", "/")]
    breadcrumbs.append(("О нас", "/about"))

    return render(request, "wallpaperfactory/about.html", {
        "breadcrumbs": breadcrumbs,
        "page": {"name": "about"},
    })


def sales(request: HttpRequest):
    breadcrumbs = [("Главная", "/")]
    breadcrumbs.append(("Акции", "/sales"))

    return render(request, "wallpaperfactory/sales.html", {
        "breadcrumbs": breadcrumbs,
        "page": {"name": "sales"},
    })


def profile_info(request: HttpRequest):
    if not request.user.is_authenticated:
        return redirect("/login")

    breadcrumbs = [("Главная", "/")]
    breadcrumbs.append((f"Профиль {request.user.username}", "/profile"))
    return render(request, "website/vue/profile.html", {
        "breadcrumbs": breadcrumbs,
        "page": {"name": "profile", "tab": "account"}
    })


def login_view(request: HttpRequest):
    breadcrumbs = [("Главная", "/")]
    breadcrumbs.append(("Вход", "/login"))
    return render(request, "website/vue/login.html", {
        "breadcrumbs": breadcrumbs,
        "page": {"name": "login"},
    })


def create_order(request: HttpRequest):
    try:
        m_sq_count = int(request.GET["m_sq_count"])
        material_id = int(request.GET["material"])
        entry_id = int(request.GET["entry"])

        material: WallpaperMaterial = WallpaperMaterial.objects.get(
            id=material_id)
        entry: WallpapersEntry = WallpapersEntry.objects.get(id=entry_id)
    except Exception:
        return redirect("/")

    breadcrumbs = [("Главная", "/")]
    breadcrumbs.append(("Заказ", request.get_full_path()))
    return render(request, "website/order.html", {
        "breadcrumbs": breadcrumbs,
        "order": {
            "m_sq_count": m_sq_count,
            "material": material.json(),
            "entry": entry.json(),
            "price": (m_sq_count * material.price) + entry.price
        }
    })


def logout_view(request: HttpRequest):
    logout(request)
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
