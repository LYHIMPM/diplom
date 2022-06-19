<template>

<div class="content-wrapper">
    <Navbar />
    <Breadcrumbs />

    <div class="content">
        <div class="profile-tabs">
            <template v-for="t in Object.keys(all_tabs)">
                <p class="tab" :class="{'current': current_tab == t}" v-text="all_tabs[t]" @click="selectTab(t)"></p>
            </template>
            <a href="/logout" class="red">Выйти</a>
        </div>

        <div class="profile-content">
            <template v-if="current_tab == 'info'">
                <ProfileEditor />
            </template>
            <template v-if="current_tab == 'orders'">
                <Orders />
            </template>
            <template v-if="current_tab == 'accounting'">
                <Accounting />
            </template>
        </div>
    </div>

</div>

</template>

<script>
import Navbar from '../../components/base/Navbar.vue'
import Breadcrumbs from '../../components/base/Breadcrumbs.vue'
import ProfileEditor from './components/ProfileEditor.vue'
import Accounting from './components/Accounting.vue'
import Orders from './components/Orders.vue'

import * as API from '../../assets/js/api'
import AreYouSureDelete from './components/AreYouSureDelete.vue'
export default {
    name: 'App',
    components: {
    Navbar,
    Breadcrumbs,
    ProfileEditor,
    Orders,
    Accounting,
    AreYouSureDelete
},
    data() {
        return {
            all_tabs: {
                "info": "Профиль",
                "orders": "Мои заказы",
                "chats": "Переписки",
            },
            current_tab: "info",
        }
    },
    methods: {
        selectTab(tab) {
            this.current_tab = tab;
        },
    },
    created: function() {
        let groups = API.getCurrentUser().groups;
        if (groups.includes("Accountant") || groups.includes("Manager")) {
            this.all_tabs.accounting = "Отчёты";
        }
        if (groups.includes("Manager")) {
            this.all_tabs.managermessages = "Связь с клиентами";
        }
        let path = location.pathname.substring(1).split("/");
        if (path.length > 1 && Object.keys(this.all_tabs).includes(path[1])) {
            this.selectTab(path[1]);
        }
    }
}
</script>


<style lang="scss">
#app {
    display: flex;
}
</style>