<template>
    <div class="profile-editor">
        <h3>Редактирование профиля</h3>
        <div class="profile-info-segment username-segment">
            <p>Имя пользователя</p>
            <input placeholder="Имя пользователя" v-model="username" type="text">
            
            <p>Email</p>
            <input placeholder="Электронная почта" v-model="email" type="text">
        </div>
    
    
        <div class="profile-info-segment fio-segment">
            <div>
                <p>Фамилия</p>
                <input placeholder="Фамилия" v-model="last_name" type="text">
            </div>
            <div>
                <p>Имя</p>
                <input placeholder="Имя" v-model="first_name" type="text">
            </div>
            <div>
                <p>Отчество</p>
                <input placeholder="Отчество" v-model="second_name" type="text">
            </div>
        </div>
    
        <div class="profile-info-segment">
            <p>Смена пароля</p>
            <input placeholder="Пароль" v-model="password1" type="text">
            <input placeholder="Повтор пароля" v-model="password2" type="text">
        </div>
    
        <div class="apply-segment">
            <p v-text="error"></p>
            <button @click="applyProfileChanges">Применить</button>
        </div>
    </div>
</template>


<script>
import * as API from '../../../assets/js/api'

let profile = API.getCurrentUser();

export default {
    name: 'ProfileEditor',
    data() {
        return {
            first_name: profile.first_name,
            last_name: profile.last_name,
            second_name: profile.second_name,
            username: profile.username,
            email: profile.email,
            password1: "",
            password2: "",
            error: null,
        }
    },
    methods: {
        
    }
}


</script>
<style lang="scss">
.profile-editor {
    padding: 20px;
    display: flex;
    flex-direction: column;
    gap: 20px;

    .profile-info-segment {
        display: flex;
        flex-direction: column;
        gap: 5px;

        input {
            width: 250px;
        }
    }

    .fio-segment {
        flex-direction: row;
        flex-wrap: wrap;
    }

    .apply-segment {
        display: grid;
        grid-template-columns: 1fr auto;
    }
}
</style>