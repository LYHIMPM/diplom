<template>
<div class="orders-wrapper">
    <h3>Заказы</h3>
    <img class="loading" v-if="loading" src="../../../assets/img/loading.gif" alt="">
    <p style="margin: 20px 0" v-if="!loading && orders.length == 0">У вас пока нет заказов</p>
    <div class="orders">
        <template v-for="order in orders">
            <div class="order-entry">
                <div>
                    <template v-if="order.is_custom">
                        <img :src="order.data.main_image" alt="">
                    </template>
                    <template v-else>
                        <img :src="order.entry.main_image" alt="">
                    </template>
                </div>

                <div>
                    <template v-if="order.is_custom">
                        <h3>Индивидуальный заказ</h3>
                    </template>
                    <template v-else>
                        <h3 v-text="'Обои ' + order.entry.name"></h3>
                    </template>

                    <p>
                        <span>Материал: </span>
                        <strong><span v-text="order.material.displayname"></span></strong>
                    </p>
                    <p v-if="order.data.m_sq_count">
                        <span>Количество квадратных метров: </span>
                        <strong><span v-text="order.data.m_sq_count"></span></strong>
                    </p>
                    <p>
                        <span>Адрес доставки: </span>
                        <strong><span v-text="order.address"></span></strong>
                    </p>
                </div>

                <div class="status-section">
                    <p class="tag yellow" v-if="order.status == 0">В процессе</p>
                    <p class="tag yellow" v-if="order.status == 1">Доставка</p>
                    <p class="tag green" v-if="order.status == 2">Завершён</p>
                    <p class="tag red" v-if="order.status == 3">Отменён</p>
                    <p class="order-date" v-text="order.human_date"></p>
                </div>
            </div>
        </template>
    </div>
</div>
</template>

<script>

import * as API from '../../../assets/js/api'

export default {
    name: 'Orders',
    components: [],
    data() {
        return {
            orders: [],
            loading: true,
        }
    },
    methods: {
        loadOrders() {
            this.loading = true;
            API.getOrders().then(resp => {
                if (resp.response != undefined) {
                    this.orders = resp.response;
                    this.loading = false;
                    console.log(this.orders);
                }
            })
        }
    },
    created() {
        console.log("Orders created");
        this.loadOrders();
    }
}
</script>
<style lang="scss">
.loading {
    margin: 100px 0;
    width: 50px;
    height: 50px;
    align-self: center;
    justify-self: center;
}

.orders {
    padding: 10px 0;
}

.order-entry {
    display: grid;
    grid-template-columns: auto 1fr auto;
    gap: 10px;

    padding: 15px;

    .tag {
        border-radius: 8px;
        padding: 5px 10px;
        font-weight: 400;
        color: var(--main-color-1);
    }

    .status-section, .status-section * {
        text-align: center;
    }

    .tag.green {
        background-color: var(--second-color-3);
    }
    .tag.yellow {
        background-color: var(--yellow-color);
    }
    .tag.red {
        background-color: var(--red-color);
    }
    

    img {
        height: 100px;
        border-radius: 5px;
    }

    h3, p {
        margin: 0;
        margin-bottom: 3px;
    }
}

.orders-wrapper {
    padding: 20px;
    display: flex;
    flex-direction: column;
    height: 100%;
}
</style>