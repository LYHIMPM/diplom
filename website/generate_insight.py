import os
import xlsxwriter
import datetime
from .models import Income, Expense, Order
from django.db.models import Avg, Sum, Min, Max, Count

def generate_file(path: str):
    workbook = xlsxwriter.Workbook(path)
    sheet = workbook.add_worksheet()

    now = datetime.datetime.now()
    strftimeformat = '%Y-%m-%d'
    date_format = workbook.add_format({'num_format': 'mm.yyyy'})

    sheet.write("B1", "Доход")
    sheet.write("C1", "Расход")
    sheet.write("D1", "Итого")

    sheet.write("F1", f"Статистика за {now.year} год")
    sheet.write("F2", "Заказов")
    sheet.write("F3", "Доход")
    sheet.write("F4", "Расход")
    sheet.write("F5", "Итого")

    for i in range(now.month):
        month_income = Income.objects.filter(
            date__month=i+1,
            date__year=now.year
        ).aggregate(result=Sum("amount"))["result"]
        month_expense = Expense.objects.filter(
            date__month=i+1,
            date__year=now.year
        ).aggregate(result=Sum("amount"))["result"]

        if month_income is None:
            month_income = 0
        if month_expense is None:
            month_expense = 0

        date = datetime.date(now.year, i+1, 1)
        sheet.write_datetime(f"A{i+2}", date, date_format)
        sheet.write(f"B{i+2}", month_income)
        sheet.write(f"C{i+2}", month_expense)
        sheet.write(f"D{i+2}", month_income - month_expense)

    year_orders = len(Order.objects.filter(date__year=now.year))
    year_income = Income.objects.filter(
        date__year=now.year
    ).aggregate(result=Sum("amount"))["result"]

    year_expense = Expense.objects.filter(
        date__year=now.year
    ).aggregate(result=Sum("amount"))["result"]

    if year_income is None:
        year_income = 0
    if year_expense is None:
        year_expense = 0

    sheet.write("G2", year_orders)
    sheet.write("G3", year_income)
    sheet.write("G4", year_expense)
    sheet.write("G5", year_income - year_expense)

    workbook.close()

    return path