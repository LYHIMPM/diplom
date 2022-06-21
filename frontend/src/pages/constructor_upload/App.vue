<template>

<div class="content-wrapper">
    <Navbar />
    <Breadcrumbs />
    
    <div class="content">
        <form class="upload-form" action="/constructor/upload" method="post" enctype="multipart/form-data">
            <h4>Загрузите картинку, из которой хотите сделать обои</h4>
            <div>
                <p>Загружайте изображения как можно большего разрешения, чтобы они хорошо выглядели на обоях.</p>
                <p>
                    Для создания фотообоев рекомендуется использовать изображения разрешением больше 1000 пикселей на 1 метр обоев.
                </p>
                <p>Поддерживаемые форматы: jpg, gif, jpeg</p>
            </div>
            <h4 class="err" v-if="payload.error" v-text="payload.error"></h4>
            <input type="hidden" name="csrfmiddlewaretoken" :value="getCSRFToken()">
            <input type="file" name="image" accept=".jpg,.jpeg,.png" />
            <input type="submit" name="submit" value="Продолжить" />
        </form>
    </div>
</div>
</template>

<script>
import Navbar from '../../components/base/Navbar.vue'
import Breadcrumbs from '../../components/base/Breadcrumbs.vue'
import * as API from '../../assets/js/api'

export default {
    name: 'App',
    components: {
        Navbar,
        Breadcrumbs
    },
    data() {
        return {
            payload: API.parsejson("payload")
        }
    },
    methods: {
        getCSRFToken() {
            return API.getCSRFToken()
        }
    }
}
</script>


<style lang="scss">
#app {
    flex: 1;
    display: flex;
    flex-direction: column;
}

.content-wrapper {
    flex: 1;
}

.upload-form {
    border-radius: 15px;
    border: 3px dotted var(--very-pale);
    padding: 50px 30px;
    backdrop-filter: blur(3px);
    max-width: 500px;

    div {
        p {
            margin: 5px;
        }
    }

    gap: 10px;
    flex-direction: column;

    h5 {
        margin: 0;
    }
}

.content, .upload-form {
    display: flex;
    justify-content: center;
    align-items: center;
}


</style>