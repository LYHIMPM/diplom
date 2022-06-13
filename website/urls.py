from django.contrib import admin
from django.urls import path

from . import views, api_views

urlpatterns = [
    path('', views.premade),
    path('premade', views.premade),
    path('premade/<int:entry_id>', views.entry_details),
    path('custom', views.custom),
    path('about', views.about),
    path('sales', views.sales),

    path('profile', views.profile_info),
    path('profile/info', views.profile_info),
    path('profile/orders', views.profile_orders),
    path('profile/chats', views.profile_chats),
    path('profile/accounting', views.profile_accounting),

    path('createorder', views.create_order),
    path('login', views.login_view),
    path('logout', views.logout_view),
    path('register', views.registration_view),

    path('api/makeOrder', api_views.make_order),
]
