from django.http import HttpRequest


def initial_data(request: HttpRequest):
    data = {"userdata": None}
    if request.user.is_authenticated:
        data["userdata"] = request.user.json()
    return data
