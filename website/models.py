# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.apps import apps
from django.contrib.auth.hashers import make_password
from django.contrib.auth.models import (AbstractBaseUser, PermissionsMixin,
                                        UserManager)
from django.db import models
import json


class Bill(models.Model):
    data = models.TextField(verbose_name="Данные (JSON)")
    status = models.IntegerField(blank=True, null=True)
    date = models.DateTimeField(verbose_name="Дата и время")
    user_id = models.IntegerField(
        verbose_name="Пользователь, совершивший транзакцию")
    order = models.ForeignKey('Order', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'bill'


class Expense(models.Model):
    amount = models.FloatField(verbose_name="Сумма")
    description = models.TextField(
        verbose_name="Описание", blank=True, default="")
    date = models.DateTimeField(verbose_name="Дата и время")
    expense_type = models.ForeignKey('ExpenseType', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'expense'
        verbose_name_plural = "Расходы"


class ExpenseType(models.Model):
    type = models.CharField(max_length=128)
    name = models.CharField(max_length=256)

    class Meta:
        managed = False
        db_table = 'expense_type'


class Income(models.Model):
    order = models.ForeignKey(
        'Order', models.DO_NOTHING, blank=True, null=True)
    income_type = models.ForeignKey('IncomeType', models.DO_NOTHING)
    amount = models.FloatField(verbose_name="Сумма")
    date = models.DateTimeField(verbose_name="Дата и время")

    class Meta:
        managed = False
        db_table = 'income'
        verbose_name_plural = "Доходы"


class IncomeType(models.Model):
    type = models.CharField(max_length=128)
    name = models.CharField(max_length=256)

    class Meta:
        managed = False
        db_table = 'income_type'


class Order(models.Model):
    entry = models.ForeignKey('WallpapersEntry',
                              models.DO_NOTHING, blank=True, null=True)
    date = models.DateTimeField(verbose_name="Дата и время")
    user_id = models.IntegerField(verbose_name="ID заказчика")
    material = models.ForeignKey('WallpaperMaterial',
                                 models.DO_NOTHING, blank=True, null=True)
    data = models.TextField(verbose_name="Данные")
    status = models.IntegerField(verbose_name="Статус", choices=[
        (0, "В процессе"),
        (1, "Доставка"),
        (2, "Завершён"),
        (3, "Отменён"),
    ])
    paymenttype = models.IntegerField(verbose_name="Способ оплаты", choices=[
        (0, "Наличными или картой при получении"),
        (1, "Банковской картой онлайн"),
    ])
    address = models.TextField(verbose_name="Адрес")
    price = models.FloatField(verbose_name="Полная цена")
    paid = models.FloatField(verbose_name="Сколько оплачено")

    class Meta:
        managed = False
        db_table = 'order'
        verbose_name_plural = "Заказы"

    def __str__(self) -> str:
        return f"<Заказ '{self.id}'>"

    @property
    def is_custom(self):
        return self.entry == None

    def json(self):
        return {
            "entry": self.entry.json() if not self.is_custom else None,
            "date": self.date.timestamp(),
            "human_date": self.date.strftime("%d.%m.%Y"),
            "user_id": self.user_id,
            "data": json.loads(self.data),
            "status": self.status,
            "price": self.price,
            "paid": self.paid,
            "is_custom": self.is_custom,
            "material": self.material.json() if not self.is_custom else None,
        }


class SiteUser(AbstractBaseUser, PermissionsMixin):
    username = models.CharField(max_length=16, unique=True,
                                blank=False, null=False)
    email = models.CharField(max_length=255, unique=True,
                             blank=False, null=False)
    first_name = models.CharField(max_length=64, null=False)
    second_name = models.CharField(max_length=64, null=True, blank=True)
    last_name = models.CharField(max_length=64, null=False)
    is_staff = models.BooleanField(null=False, default=False, blank=True)
    is_superuser = models.BooleanField(null=False, default=False, blank=True)
    is_active = models.BooleanField(null=False, default=False, blank=True)

    @property
    def safe_second_name(self):
        if self.second_name is None:
            return ""
        return self.second_name

    objects = UserManager()

    class Meta:
        # id было incompatible, пришлось включить чтобы создалось само
        managed = False
        db_table = 'website_siteuser'
        verbose_name_plural = "Пользователи"

    @property
    def is_active(self):
        return True

    USERNAME_FIELD = "email"
    REQUIRED_FIELDS = ['username', 'first_name', 'last_name']


class Tag(models.Model):
    tag = models.CharField(unique=True, max_length=45, verbose_name="тэг")
    displaytag = models.CharField(
        max_length=45, verbose_name="Отображаемое название")

    class Meta:
        managed = False
        db_table = 'tag'
        verbose_name_plural = "Тэги"

    def json(self):
        return {
            "tag": self.tag,
            "displaytag": self.displaytag
        }

    def __str__(self) -> str:
        return f"<Тэг '{self.displaytag}'>"


class Chat(models.Model):
    id = models.BigIntegerField(primary_key=True)
    client = models.ForeignKey('Siteuser', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'chat'


class Message(models.Model):
    id = models.BigIntegerField(primary_key=True)
    chat = models.ForeignKey(Chat, models.DO_NOTHING)
    sender = models.ForeignKey('Siteuser', models.DO_NOTHING)
    text = models.TextField()
    datetime = models.DateTimeField(db_column='DATETIME')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'message'


class WallpaperMaterial(models.Model):
    name = models.CharField(max_length=64,
                            verbose_name="Кодовое название")
    displayname = models.CharField(max_length=64,
                                   verbose_name="Отображаемое название")
    price = models.FloatField(verbose_name="Цена за 1 кв. м.")
    image_url = models.CharField(max_length=512,
                                 verbose_name="Ссылка на изображение")

    parameters = models.ManyToManyField(
        "MaterialParameter",
        through='MaterialHasParameter',
        verbose_name="Свойства"
    )

    @property
    def main_image(self):
        return "/static/wallpaperfactory/img/materials/"+self.image_url + (".jpg" if not (self.image_url.endswith(".jpg") or self.image_url.endswith(".png")) else "")

    class Meta:
        managed = False
        db_table = 'wallpaper_material'
        verbose_name_plural = "Материалы обоев"

    def json(self):
        return {
            "id": self.id,
            "name": self.name,
            "displayname": self.displayname,
            "image_url": self.main_image,
            "price": self.price,
            "tags": [p.id for p in self.parameters.all()]
        }

    def __str__(self) -> str:
        return f"<Материал {self.displayname}>"


class MaterialHasParameter(models.Model):
    # id = models.CharField(primary_key=True, max_length=45)
    wallpaper_material = models.ForeignKey('WallpaperMaterial', models.DO_NOTHING)
    material_parameter = models.ForeignKey('MaterialParameter', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'material_has_parameter'


class MaterialParameter(models.Model):
    name = models.CharField(max_length=128)
    displayname = models.CharField(max_length=255)

    class Meta:
        managed = False
        db_table = 'material_parameter'
        verbose_name_plural = "Свойства материалов"

    def json(self):
        return {
            "id": self.id,
            "name": self.name,
            "displayname": self.displayname
        }

    def __str__(self) -> str:
        return f"<Свойство материала '{self.displayname}'>"


class WallpapersEntry(models.Model):
    name = models.CharField(max_length=256, verbose_name="Название")
    description = models.TextField(
        verbose_name="Описание", blank=True, default="")
    price = models.FloatField(verbose_name="Цена, ₽")
    image_url = models.CharField(max_length=512,
                                 verbose_name="Ссылка на изображение")
    full_picture = models.BooleanField(
        default=False, verbose_name="Цельное изображение")

    tags = models.ManyToManyField(
        "Tag",
        through='WallpapersPremadeEntryHasTag',
        verbose_name="Тэги"
    )

    class Meta:
        managed = False
        db_table = 'wallpapers_premade_entry'
        verbose_name_plural = "Готовые обои"

    def json(self):
        return {
            "id": self.id,
            "name": self.name,
            "description": self.description,
            "full_picture": self.full_picture,
            "price": self.price,
            "image_url": self.image_url,
            "main_image": self.main_image,
            "tags": [tag.json() for tag in self.tags.all()]
        }

    @property
    def main_image(self):
        return "/static/wallpaperfactory/img/premade_wallpapers/"+self.image_url

    def __str__(self) -> str:
        return f"<Обои {self.name}>"


class WallpapersPremadeEntryHasTag(models.Model):
    wallpapers_premade_entry = models.ForeignKey(
        WallpapersEntry, models.DO_NOTHING)
    tag = models.ForeignKey(Tag, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'wallpapers_premade_entry_has_tag'
        unique_together = (('wallpapers_premade_entry', 'tag'),)
