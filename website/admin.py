from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from django.contrib.auth.models import AbstractUser
from django.utils.html import format_html

from . import models


class WallpapersPremadeEntryTagInline(admin.TabularInline):
    model = models.WallpapersEntry.tags.through
    fk_name = "wallpapers_premade_entry"
    extra = 0


class WallpaperMaterialParameterInline(admin.TabularInline):
    model = models.WallpaperMaterial.parameters.through
    fk_name = "wallpaper_material"
    extra = 0


@admin.register(models.MaterialParameter)
class MaterialParameterAdmin(admin.ModelAdmin):
    list_display = ["id", "name", "displayname"]


@admin.register(models.Tag)
class TagAdmin(admin.ModelAdmin):
    list_display = ["id", "tag", "displaytag"]
    list_display_links = ['tag']


@admin.register(models.WallpapersEntry)
class WallpapersPremadeEntriesAdmin(admin.ModelAdmin):
    inlines = [WallpapersPremadeEntryTagInline]
    list_display = ["icon", "id", "name", "price", "description"]
    list_display_links = ['name']

    def icon(self, obj: models.WallpapersEntry):
        if obj is not None:
            return format_html(f'<img src="{obj.main_image}" style="width: 150px">')
        return ""


@admin.register(models.WallpaperMaterial)
class WallpaperMaterialAdmin(admin.ModelAdmin):
    inlines = [WallpaperMaterialParameterInline]
    list_display = ["icon", "id", "name", "displayname", "price"]
    list_display_links = ['name']

    def icon(self, obj: models.WallpapersEntry):
        if obj is not None:
            return format_html(f'<img src="{obj.main_image}" style="width: 80px">')
        return ""

@admin.register(models.Order)
class OrderAdin(admin.ModelAdmin):
    list_display = ["id", "entry_id", "date", "user_id", "data",
                    "status", "price", "paid"]