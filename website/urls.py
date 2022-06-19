from django.contrib import admin
from django.urls import path, re_path

from . import views, api_views

urlpatterns = [
    path('', views.premade),
    path('premade', views.premade),
    path('premade/<int:entry_id>', views.entry_details),
    path('custom', views.iwantcustom),
    path('about', views.about),
    path('sales', views.sales),
    re_path(r'profile/.*', views.profile_info),

    path('createorder', views.create_order),
    path('login', views.login_view),
    path('logout', views.logout_view),
    path('register', views.registration_view),

    path('api/getReports', api_views.get_reports),
    path('api/createReport', api_views.create_report),
    path('api/deleteReport', api_views.delete_report),
    path('report/<str:name>', api_views.download_report),

    path('api/makeOrder', api_views.make_order),
    path('api/getOrders', api_views.get_orders),
    path('api/getPremade', api_views.get_premade),
    path('api/getOrderPlaces', api_views.get_order_places),
    path('api/login', api_views.login_view),
]
