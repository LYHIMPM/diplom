<template>

<div class="content-wrapper">
    <Navbar />
    <Breadcrumbs />
    
    <div class="content">
        <div class="section custom-contact-us">
            <img class="section-img" src="../../assets/img/designer.webp" alt="">
            <h3>Заказать работу дизайнера</h3>
            <p class="section-description">
                Обратитесь к нашим дизайнерам и опишите, какие обои вы хотели бы видеть.
                <br>
                Наши эксперты в области дизайна интерьеров создадут неповторимый дизайн специально для вас.
            </p>
            <button>Написать</button>
        </div>
        <div class="section custom-constructor">
            <img class="section-img" src="../../assets/img/puzzle.webp" alt="">
            <h3>Создать свой дизайн при помощи конструктора</h3>
            <p class="section-description">
                Вы можете создать свой собственный дизайн, загрузив любое изображение и настроив его положение при помощи удобного конструктора, а затем заказать обои с созданным дизайном.
            </p>
            <button>Попробовать</button>
        </div>
    </div>
</div>
</template>

<script>
import Navbar from '../../components/base/Navbar.vue'
import Breadcrumbs from '../../components/base/Breadcrumbs.vue'
import * as utils from '../../assets/js/utils'
import * as API from '../../assets/js/api'

export default {
    name: 'App',
    components: {
        Navbar,
        Breadcrumbs
    },
    data() {
        return {
            order: utils.parsejson("order"),
            first_name: API.getCurrentUser().first_name,
            last_name: API.getCurrentUser().last_name,
            email: API.getCurrentUser().email,
            address: "",
            paymenttype: 0
        }
    },
    methods: {
        getOrderData: function() {
            return {
                order: this.order,
                address: this.address,
                paymenttype: this.paymenttype
            }
        },
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

.content {
    display: grid;
    flex: 1;
    height: 100%;
    grid-template-columns: 1fr 1fr;

    .section {
        display: grid;
        grid-template-rows: auto auto 1fr 1fr;
        flex-direction: column;
        margin: 30px 10px;
        padding: 20px;
        border-radius: 20px;
        box-shadow: 0 0 30px #00000010;
        background: var(--main-color-1);
        
        .section-img {
            width: 160px;
            height: 160px;
            object-fit: cover;
            border-radius: 50%;
            align-self: center;
            margin-top: -50px;
            margin-bottom: 10px;
            justify-self: center;
        }

        h3 {
            text-align: center;
        }

        button {
            width: 50%;
            height: 40px;
            align-self: center;
            justify-self: center;
        }

        .section-description {
            font-size: 17px;
            padding: 10%;
        }
    }
}


</style>