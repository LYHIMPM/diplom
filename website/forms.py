from django import forms

class LoginForm(forms.Form):
    email = forms.EmailField(required=False, label="", widget=forms.TextInput(attrs={'placeholder': 'Электронная почта'}))
    password = forms.CharField(max_length=16, min_length=3, required=True, label="", widget=forms.PasswordInput(attrs={'placeholder': 'Пароль'}))

class RegistrationForm(forms.Form):
    username = forms.CharField(max_length=16, min_length=3, required=True, label="", widget=forms.TextInput(attrs={'placeholder': 'Имя пользователя'}))
    email = forms.EmailField(required=True, label="", widget=forms.TextInput(attrs={'placeholder': 'Электронная почта'}))

    first_name = forms.CharField(max_length=64, min_length=2, required=True, label="", widget=forms.TextInput(attrs={'placeholder': 'Имя'}))
    last_name = forms.CharField(max_length=64, min_length=2, required=True, label="", widget=forms.TextInput(attrs={'placeholder': 'Фамилия'}))
    second_name = forms.CharField(max_length=64, min_length=2, label="", widget=forms.TextInput(attrs={'placeholder': 'Отчество'}))

    password = forms.CharField(max_length=16, min_length=3, required=True, label="", widget=forms.PasswordInput(attrs={'placeholder': 'Пароль'}))


class ConstructorFileUploadForm(forms.Form):
    file = forms.FileField()