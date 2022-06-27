<template>

<div class="content-wrapper">
    <Navbar />
    <Breadcrumbs />
    
    <div class="content">
        <h4>Студия дизайнерских обоев "Astra"</h4>

        <p>Дипломный проект выполнен студентом Филином Павлом Сергеевичем, 402 Прг</p>
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


.content {
    display: flex;
    flex-direction: column;

    align-items: center;
}


</style>