<template>

<div class="modal-bg" @click.self="$emit('closeLoginModal')">
    <div class="modal login-modal">
        <div>
            <h2>Вход</h2>
            <h5 v-if="wrong" class="red">Данные неверны</h5>
        </div>
        <div>
            <p>Электронная почта</p>
            <input v-model="email" type="email">
        </div>
        <div>
            <p>Пароль</p>
            <input v-model="password" type="password">
            <a href="/register" class="no-account">Нет аккаунта?</a>
        </div>
        <div>
            <button @click="login">Войти</button>
        </div>
    </div>
</div>

</template>

<script>
import {login} from '../../assets/js/api'

export default {
    name: 'Login',
    emits: ['login', 'closeLoginModal'],
    data() {
        return {
            shown: false,
            email: "",
            password: "",
            wrong: false,
        }
    },
    methods: {
        login() {
            login(this.email, this.password).then((data) => {
                if (data.response.userdata == undefined) {
                    this.wrong = true;
                } else {
                    location.reload();
                }
            });
            
        }
    }
}
</script>


<style lang="scss">
    .login-modal {
        background: #fff;
        padding: 50px;
        border: 1px solid var(--very-pale);
        border-radius: 15px;
        box-shadow: 5px 5px 50px #00000031;

        display: flex;
        flex-direction: column;
        gap: 10px;

        div {
            display: flex;
            flex-direction: column;
            a {
                margin-top: 10px;
            }
        }

        h2 {
            text-align: center;
        }
    }
</style>