<template>

<div class="content-wrapper">
    <Navbar />
    <Breadcrumbs />
    
    <div class="content" id="app">
        <h2>Оформление заказа</h2>

        <template v-if="!ordered">
            <div class="order-entry">
                <div>
                    <img :src="order.entry.main_image" alt="">
                </div>
                <div>
                    <h3 v-text="'Обои ' + order.entry.name"></h3>
                    <p>
                        <span>Материал: </span>
                        <strong><span v-text="order.material.displayname"></span></strong>
                    </p>
                    <p>
                        <span>Количество квадратных метров: </span>
                        <strong><span v-text="order.m_sq_count"></span></strong>
                    </p>
                </div>
            </div>
            <div class="order-data">
                <div class="contact">
                    <h3>1. Контактные данные</h3>
        
                    <div class="contact-credentials">
                        <div>
                            <input v-model="first_name" type="text" placeholder="Имя">
                            <input v-model="last_name" type="text" placeholder="Фамилия">
                        </div>
                        <div>
                            <input v-model="email" type="email" placeholder="Email">
                        </div>
                    </div>
                </div>
        
                <div class="address">
                    <h3>2. Адрес доставки</h3>
                    <p style="margin: 5px 0">Выберите пункт выдачи</p>
                    <select v-model="orderPlaceID">
                        <template v-for="place in orderPlaces">
                            <option :value="place.id" v-text="place.address"></option>
                        </template>
                    </select>
                </div>
        
                <div class="order-paymenttype">
                    <h3>3. Способ оплаты</h3>
                    
                    <div>
                        <div>
                            <input v-model="paymenttype" type="radio" value="0" name="paymenttype" id="paymenttype-nal">
                            <label for="paymenttype-nal">Наличными или картой при получении</label>
                        </div>
                        <div>
                            <input v-model="paymenttype" type="radio" value="1" name="paymenttype" id="paymenttype-online">
                            <label for="paymenttype-online">Банковской картой онлайн</label>
                        </div>
                    </div>
                </div>
        
                <div class="order-checkout">
                    <h3>Итого к оплате: {{ order.price }} ₽</h3>
                    <p v-if="!isAllDataFilled" class="red">Не все данные заполнены</p>
                    <button :disabled="!isAllDataFilled" @click="createOrder" style="float: right; width: 200px">Оформить заказ</button>
                </div>
            </div>
        </template>
        <template v-else>
            <div class="order-done">
                <div>
                    <h3>Ваш заказ успешно добавлен</h3>
                    <a href="/profile/orders">Перейти на страницу заказов</a>
                </div>
            </div>
        </template>
    </div>
</div>
</template>

<script>
import Navbar from '../../components/base/Navbar.vue'
import Breadcrumbs from '../../components/base/Breadcrumbs.vue'
import * as utils from '../../assets/js/utils'
import * as API from '../../assets/js/api'
import { throwStatement } from '@babel/types'

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
            paymenttype: 0,
            ordered: false,
            orderPlaces: [],
            orderPlaceID: null,
        }
    },
    computed: {
        isAllDataFilled: function() {
            return  !(this.first_name == null || this.first_name.replace(" ", "").length < 3 ||
                 this.last_name == null || this.last_name.replace(" ", "").length < 3 ||
                 this.email == null || this.email.replace(" ", "").length < 5 ||
                 this.orderPlaceID == null || !([1, 0].includes(this.paymenttype)));
        }
    },
    methods: {
        createOrder: function() {
            API.makeOrder(
                this.order.entry.id,
                this.order.material.id,
                this.order.m_sq_count,
                this.paymenttype,
                this.orderPlaceID,
                this.first_name,
                this.last_name,
                this.email,
            ).then(data => {
                // console.log(data);
                this.ordered = true;
            });
        },
    },
    created: function() {
        API.getOrderPlaces().then(data => {
            this.orderPlaces = data.response;
        });
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
    flex: 1;
    flex-direction: column;
    padding: 20px;
    gap: 20px;

    background-color: var(--main-color-1);
}

.order-done {
    flex: 1;
    display: flex;
    align-items: center;
    justify-content: center;

    * {
        text-align: center;
    }
}


.order-entry {
    display: grid;
    grid-template-columns: auto 1fr;
    gap: 10px;

    padding: 10px;
    background-color: var(--main-color-2);

    img {
        height: 100px;
        border-radius: 5px;
    }

    h3, p {
        margin: 0;
        margin-bottom: 3px;
    }
}

.order-data {
    display: flex;
    flex-direction: column;
    gap: 10px;

    h2, h1, h3 {
        margin: 10px 0;
    }

    .order-paymenttype > div {
        display: flex;
        flex-direction: column;
        gap: 10px;
    }
    .order-checkout {
        display: flex;
        justify-content: space-between;
        button {
            padding: 15px;
        }
    }
}

.contact-credentials {
    display: flex;
    flex-direction: column;
    gap: 10px;

    div {
        display: flex;
        flex-direction: row;
        gap: 10px;
    }
}
</style>