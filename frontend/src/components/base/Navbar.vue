<template>
<nav>
    <template v-if="loginModalShown">
        <Login @login="login($event)" @closeModal="closeModal" />
    </template>

    <div class="logo">
        <a href="/">
            <h1>ASTRA</h1>
            <p>ДИЗАЙНЕРСКИЕ ОБОИ</p>
        </a>
    </div>
    <div class="navbar-links">
        <template v-for="p in pages">
            <a :href="'/'+p[0]" class="navbar-link" :class="{'current': page.name == p[0]}" v-text="p[1]"></a>
        </template>
    </div>
    <div>
        <div class="login-btn">
            <template v-if="user == null">
                <p @click="openLoginModal" class="navbar-link clickable" :class="{'current': page.name == 'login'}">Войти</p>
            </template>
            <template v-else>
                <a href="/profile" class="navbar-link" :class="{'current': page.name == 'profile'}" v-text="user.username"></a>
            </template>
        </div>
    </div>
</nav>
</template>

<script>
import { getCurrentUser, parsejson } from '../../assets/js/api'
import Login from './Login'

export default {
    name: "Navbar",
    components: {
        Login
    },
    data() {
        return {
            pages: [
                ["premade", "Готовые обои"],
                ["custom", "Хочу свой дизайн!"],
                ["about", "О нас"]
            ],
            user: getCurrentUser(),
            page: parsejson("page", false),
            loginModalShown: false,
        }
    },
    methods: {
        login(event) {
            this.emit('login', event);
            this.closeModal();
        },
        closeModal() {
            this.loginModalShown = false;
        },
        openLoginModal() {
            this.loginModalShown = true;
        },
    }
}

</script>