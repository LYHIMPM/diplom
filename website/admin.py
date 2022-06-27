from django.contrib import admin
from django.utils.html import format_html
from django.utils.translation import gettext_lazy as _

from . import models


class WallpapersPremadeEntryTagInline(admin.TabularInline):
    model = models.WallpapersEntry.tags.through
    fk_name = "wallpapers_premade_entry"
    extra = 0


class WallpaperMaterialParameterInline(admin.TabularInline):
    model = models.WallpaperMaterial.parameters.through
    fk_name = "wallpaper_material"
    extra = 0


@admin.register(models.SiteUser)
class SiteUserAdmin(admin.ModelAdmin):
    list_display = ["id", "username"]


@admin.register(models.IncomeType)
class IncomeTypeAdmin(admin.ModelAdmin):
    list_display = ["type", "name"]


@admin.register(models.ExpenseType)
class ExpenseTypeAdmin(admin.ModelAdmin):
    list_display = ["type", "name"]


@admin.register(models.Income)
class IncomeAdmin(admin.ModelAdmin):
    list_display = ["date", "amount", "income_type", "order"]
    ordering = ["-date"]


@admin.register(models.Expense)
class ExpenseAdmin(admin.ModelAdmin):
    list_display = ["date", "amount", "expense_type"]
    ordering = ["-date"]


@admin.register(models.MaterialParameter)
class MaterialParameterAdmin(admin.ModelAdmin):
    list_display = ["id", "name", "displayname"]


@admin.register(models.Tag)
class TagAdmin(admin.ModelAdmin):
    list_display = ["tag", "displaytag"]
    list_display_links = ['tag']


@admin.register(models.OrderPlace)
class OrderPlaceAdmin(admin.ModelAdmin):
    list_display = ["name", "address"]
    list_display_links = ['name']


class CustomPremadeFilter(admin.SimpleListFilter):
    title = _("Тип")
    parameter_name: str = "filtercustom"

    def lookups(self, request, model_admin):
        return (
            (None, _("Скрыть пользовательские")),
            ("custom", _("Только пользовательские")),
            ("all", _("Все")),
        )

    def choices(self, cl):
        for lookup, title in self.lookup_choices:
            yield {
                'selected': self.value() == lookup,
                'query_string': cl.get_query_string({
                    self.parameter_name: lookup,
                }, []),
                'display': title,
            }

    def queryset(self, request, queryset):
        if self.value() == None:
            return queryset.filter(custom=False)
        elif self.value() == "custom":
            return queryset.filter(custom=True)
        return queryset


@admin.register(models.WallpapersEntry)
class WallpapersPremadeEntriesAdmin(admin.ModelAdmin):
    inlines = [WallpapersPremadeEntryTagInline]
    list_display = ["icon", "id", "name", "price", "description"]
    list_display_links = ['name']
    search_fields = ["name", "displayname", "price", "id"]

    list_filter = [CustomPremadeFilter]

    def icon(self, obj: models.WallpapersEntry):
        if obj is not None:
            return format_html(f'<img src="{obj.main_image}" style="width: 150px">')
        return ""


@admin.register(models.WallpaperMaterial)
class WallpaperMaterialAdmin(admin.ModelAdmin):
    inlines = [WallpaperMaterialParameterInline]
    list_display = ["icon", "name", "displayname", "price"]
    list_display_links = ['name']
    search_fields = ["name", "displayname"]

    def icon(self, obj: models.WallpapersEntry):
        if obj is not None:
            return format_html(f'<img src="{obj.main_image}" style="width: 80px">')
        return ""


@admin.register(models.Order)
class OrderAdmin(admin.ModelAdmin):
    list_display = ["id", "entry_id", "date", "user_id", "data",
                    "status", "price", "paid"]
    ordering = ["-date"]
    search_fields = ["date", "price"]
