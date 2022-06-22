<template>
<div class="modal-bg" @click.self="$emit('closeModal')">
    <div class="modal login-modal">
        <template v-if="registerShown">
            <Register @registered="$emit('login')"  @close-modal="registerShown = false" />
        </template>
        <div>
            <h2>Вход</h2>
            <h5 v-if="wrong" class="red">Данные неверны</h5>
        </div>
        <div>
            <p>Электронная почта</p>
            <input v-model="email" name="email" type="email" placeholder="Email">
        </div>
        <div>
            <p>Пароль</p>
            <input v-model="password" name="password" type="password" placeholder="Пароль">
            <p @click="registerShown = true" class="no-account">Нет аккаунта?</p>
        </div>
        <div>
            <button @click="login">Войти</button>
        </div>
    </div>
</div>

</template>

<script>
import {login} from '../../assets/js/api'
import Register from './Register.vue';

export default {
    name: "Login",
    emits: ["login", "closeModal"],
    components: [Register],
    data() {
        return {
            shown: false,
            registerShown: false,
            email: "",
            password: "",
            wrong: false,
        };
    },
    methods: {
        login() {
            login(this.email, this.password).then((data) => {
                if (data.response == null) {
                    this.wrong = true;
                }
                else {
                    location.reload();
                }
            });
        }
    },
    components: { Register }
}
</script>


<style lang="scss">
    .login-modal {
        background: #fff;
        padding: 50px;
        border: 1px solid var(--very-pale);
        border-radius: 15px;
        box-shadow: 5px 5px 50px #00000031;

        min-width: 400px;

        display: flex;
        flex-direction: column;
        gap: 10px;

        .no-account {
            cursor: pointer;
        }
        .no-account:hover {
            text-decoration: underline;
        }

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