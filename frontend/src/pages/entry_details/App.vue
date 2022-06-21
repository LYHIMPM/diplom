<template>

    <div class="content-wrapper">
        <Navbar />
        <Breadcrumbs />

        <div class="content">
            <div class="entry-bg">

                <img style="width: 100%;" :src="entry.main_image" alt="">

                <div class="info-section">
                    <h2 v-text="'Обои ' + entry.name"></h2>

                    <div>
                        <p v-text="entry.description"></p>
                    </div>

                    <div class="info-column">
                        <div>
                            <strong>Сколько обоев вам нужно?</strong>

                            <div class="rooms-calc">
                                <p>Стены:</p>
                                <template v-for="ri in Object.keys(rooms)">
                                    <div class="calculator-room-entry">
                                        <input v-model="rooms[ri][0]" placeholder="Ширина, м"
                                            oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
                                        <p>на</p>
                                        <input v-model="rooms[ri][1]" placeholder="Высота, м"
                                            oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">

                                        <p v-if="Object.keys(rooms).length != 1" @click="remove_wall(ri)"
                                            class="remove">удалить</p>
                                    </div>
                                </template>
                                <button style="width: 140px;" v-if="m_sq_count" @click="add_wall">+ Стена</button>
                            </div>
                        </div>

                        <div>
                            <p>Дизайн: <span v-text="entry.name"></span>: <strong> <span v-text="entry.price"></span>
                                    ₽</strong></p>
                            <p>Материал: <span v-text="currentMaterial.displayname"></span>: <strong><span
                                        v-text="currentMaterial.price"></span> ₽ / м. кв.</strong></p>
                            <p>Площадь:
                                <strong>
                                    <template v-if="sq_entered">
                                        <span v-text="m_sq_count + 'кв. м.'"></span>
                                    </template>
                                    <template v-else>
                                        <span class="err">Не введено</span>
                                    </template>
                                </strong>
                            </p>
                        </div>

                        <div>
                            <h4>Подбор материала</h4>
                            <MaterialSelector :material-tags="materialTags" :materials="materials" @material-selected="currentMaterial=$event" />
                        </div>

                        <div class="price-section">
                            <h3>Итоговая цена:
                                <template v-if="sq_entered">
                                    <span class="price" v-text="calc_price + ' ₽'"></span>
                                </template>
                                <template v-else>
                                    <span class="price">Введите площадь, чтобы увидеть цену</span>
                                </template>
                            </h3>
                            <button v-on:click="order" v-if="m_sq_count > 0">Заказать</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import Navbar from '../../components/base/Navbar.vue'
import Breadcrumbs from '../../components/base/Breadcrumbs.vue'
import * as API from '../../assets/js/api'
import MaterialSelector from '../../components/MaterialSelector.vue'

export default {
    name: 'App',
    components: {
    Navbar,
    Breadcrumbs,
    MaterialSelector
},
    data() {
        return {
            entry: API.parsejson("entry"),
            materialTags: API.parsejson("material_tags"),
            materials: API.parsejson("materials"),
            roll_width: 53,
            meters_in_roll: 10,
            currentMaterial: {},
            rooms: {
                0: [null, null]
            },
        }
    },
    methods: {
        remove_wall(key) {
            delete this.rooms[key];
        },

        add_wall() {
            this.rooms[Object.keys(this.rooms).length] = [null, null]
        },

        get_create_order_uri: function () {
            const params = new URLSearchParams({
                'm_sq_count': this.m_sq_count,
                'entry': this.entry.id,
                'material': this.currentMaterial.id
            });
            return '/createorder?' + params.toString();
        },

        order: function () {
            location.href = this.get_create_order_uri();
        },
    },
    computed: {
        m_sq_count: function () {
            let meters = 0;
            let keys = Object.keys(this.rooms);

            keys.forEach(k => {
                const room = this.rooms[k];
                if (!(room[0] == null || room[1] == null)) {
                    meters += room[0] * room[1];
                }
            });
            return meters;
        },
        sq_entered: function () {
            return this.m_sq_count != NaN && this.m_sq_count != 0;
        },
        calc_price: function () {
            return this.entry.price + (this.currentMaterial.price * this.m_sq_count);
        },
        hasNotFilledWalls() {
            this.rooms.forEach(wall => {
                if (wall[0] == null || wall[1] == null) {
                    return true;
                }
            });
            return false;
        }
    },
    created: function () {
    }
}
</script>


<style lang="scss">

.entry-bg {
    display: grid;
    grid-template-columns: 1fr 1.7fr;
    padding: 20px;
    background-color: var(--main-color-1);
    gap: 40px;
}

.rooms-calc {
    display: flex;
    flex-direction: column;
    margin: 5px 0;
    gap: 5px;

    p {
        margin: 0;
    }

    .calculator-room-entry {
        display: flex;
        gap: 10px;

        align-items: center;

        .remove {
            text-decoration: underline;
            cursor: pointer;
        }
    }

    input {
        width: 110px;
    }
}

.info-column {
    display: flex;
    flex-direction: column;
    gap: 20px;
}

.price-section {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
}

h2, h3, h4, p {
    margin: 5px 0;
}
h2 {
    font-size: 1.35em;
}

.price {
    color: var(--text-color-2);
}

.info-section {
    display: flex;
    flex-direction: column;
    justify-content: flex-start;

    input {
        display: block;
        margin: 3px 0;
    }
}
</style>