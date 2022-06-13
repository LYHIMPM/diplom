from django.db.models import Avg, Count, Max, Min, Sum
from django.db.models.query_utils import Q
from django.http import HttpRequest, HttpResponseForbidden, JsonResponse
from django.shortcuts import render, redirect
from .forms import LoginForm, RegistrationForm, UpdateAccountInfoForm
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth import authenticate, login, logout
import math
import json

from .models import MaterialParameter, SiteUser, Tag, WallpaperMaterial, WallpapersEntry, Order


def make_order(request: HttpRequest):
    if not request.user.is_authenticated:
        return HttpResponseForbidden()

    data = json.loads(request.body)
    print(data)
    # order = Order.objects.create(
    #     entry=
    # )

    return JsonResponse({})
