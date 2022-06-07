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


class UpdateAccountInfoForm(forms.Form):
    username = forms.CharField(required=False, max_length=16, min_length=3, label="", widget=forms.TextInput(attrs={'placeholder': 'Имя пользователя', 'v-model': 'acc_info_username'}))
    email = forms.EmailField(required=False, label="", widget=forms.TextInput(attrs={'placeholder': 'Электронная почта', 'v-model': 'acc_info_email'}))

    first_name = forms.CharField(required=False, max_length=64, min_length=2, label="", widget=forms.TextInput(attrs={'placeholder': 'Имя', 'v-model': 'acc_info_first_name'}))
    last_name = forms.CharField(required=False, max_length=64, min_length=2, label="", widget=forms.TextInput(attrs={'placeholder': 'Фамилия', 'v-model': 'acc_info_last_name'}))
    second_name = forms.CharField(required=False, max_length=64, min_length=2, label="", widget=forms.TextInput(attrs={'placeholder': 'Отчество', 'v-model': 'acc_info_second_name'}))

    password = forms.CharField(required=False, max_length=16, min_length=3, label="", widget=forms.PasswordInput(attrs={'placeholder': 'Пароль'}))
    password_repeat = forms.CharField(required=False, max_length=16, min_length=3, label="", widget=forms.PasswordInput(attrs={'placeholder': 'Пароль ещё раз'}))