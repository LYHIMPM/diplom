<template>

<div class="modal-bg" @click.self="$emit('closeModal')">
    <div class="modal register-modal">
        <div>
            <h2>Регистрация</h2>
            <h5 v-if="wrong" class="err" v-text="error_text"></h5>
        </div>
        <div>
            <p>Имя пользователя</p>
            <input v-model="username" name="username" type="text" placeholder="Имя пользователя">
        </div>
        <div>
            <p>Электронная почта</p>
            <input v-model="email" name="email" type="email" placeholder="Email">
        </div>
        <div>
            <p>Имя, Фамилия, Отчество</p>
            <input v-model="first_name" type="text" placeholder="Имя">
            <input v-model="last_name" type="text" placeholder="Фамилия">
            <input v-model="second_name" type="text" placeholder="Отчество">
        </div>
        <div>
            <p>Пароль</p>
            <input v-model="password1" name="password" type="password" placeholder="Пароль (6-32 символов)">
            <input v-model="password2" name="password" type="password" placeholder="Повторите пароль">
        </div>
        <template v-if="loading">
            <div class="loading">
                <img src="../../assets/img/loading.gif" alt="" />
            </div>
        </template>
        <template v-else>
            <div>
                <p v-if="notAllDataFilled" class="err">Не все данные правильно заполнены</p>
                <button :disabled="passwordsDoesNotMatch || notAllDataFilled" @click="register">Зарегистрироваться</button>
            </div>
        </template>
    </div>
</div>

</template>

<script>
import {register} from '../../assets/js/api'

export default {
    name: 'Register',
    emits: ['registered', 'closeModal'],
    data() {
        return {
            shown: false,
            email: "",
            password1: "",
            password2: "",
            first_name: "",
            second_name: "",
            username: "",
            last_name: "",
            wrong: false,
            loading: false,
            error_text: "Введены некорректные данные",
        }
    },
    computed: {
        passwordsDoesNotMatch: function() {
            return this.password1 != this.password2;
        },
        notAllDataFilled: function() {
            return this.email.length < 5 || this.password1.length < 6 || this.password2.length < 6 || this.first_name.length < 2 || this.last_name.length < 2 || this.username.length < 3 || this.username.length > 16;
        }
    },
    methods: {
        register() {
            this.loading = true;
            register(this.username, this.first_name, this.last_name, this.second_name, this.email, this.password1).then(data => {
                this.loading = false;
                if (data.response == null) {
                    this.wrong = true;
                    if (data.error.code == 5) {
                        this.error_text = "Эта почта уже зарегистрирована!";
                    } else if (data.error.code == 6) {
                        this.error_text = "Это имя пользователя уже зарегистрировано!";
                    } else if (data.error.code == 2) {
                        this.error_text = "Введены некорректные данные!";
                    } else if (data.error.code != null) {
                        this.error_text = `Неизвестная ошибка (${data.error.code}). Попробуйте позже.`;
                    } else {
                        console.log(data);
                        this.error_text = `Неизвестная ошибка. Попробуйте позже.`;
                    }
                } else {
                    location.reload();
                }
            });
            
        }
    }
}
</script>


<style lang="scss">
    .register-modal {
        background: #fff;
        padding: 50px;
        border: 1px solid var(--very-pale);
        border-radius: 15px;
        box-shadow: 5px 5px 50px #00000031;
        min-width: 400px;

        display: flex;
        flex-direction: column;
        gap: 10px;

        div {
            p {
                margin: 4px;
            }
            display: flex;
            flex-direction: column;
            gap: 3px;
            a {
                margin-top: 10px;
            }
        }

        h2 {
            text-align: center;
        }

        div.loading {
            display: flex;
            justify-content: center;
            align-content: center;
            flex-direction: column;
            img {
                width: 35px;
                height: 35px;
                align-self: center;
            }
        }
    }
</style>