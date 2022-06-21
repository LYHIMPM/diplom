<template>

    <div class="content-wrapper">
        <Navbar />
        <Breadcrumbs />

        <div class="content">

            <div id="viewport-wrapper" class="viewport-wrapper">
                <div id="viewport" class="viewport"
                    :style="{ height: vpY + '%', width: vpX + '%', 'background-size': vpColumnWidth * imgSize + '%' }">
                    <div class="columns-preview">
                        <template v-for="c in Math.max(1, vpColumnCount)">
                            <div class="column" :style="{ width: vpColumnWidth + '%' }"><br /> <br /></div>
                        </template>
                    </div>
                </div>
            </div>
            <div class="params">
                <h3>Параметры</h3>

                <div>
                    <p>Ширина стены в метрах</p>
                    <input @change="calcViewportWidthHeight" @wheel="scrollWidth" v-model="wallWidth" type="number" step="0.5"
                        placeholder="Ширина">
                </div>
                <div>
                    <p>Высота стены в метрах</p>
                    <input @change="calcViewportWidthHeight" @wheel="scrollHeight" v-model="wallHeight" type="number" step="0.5"
                        placeholder="Высота">
                </div>

                <div>
                    <p>Размер изображения (1 = метр)</p>
                    <input v-model="imgSize" type="number" step="0.1" placeholder="Высота">
                </div>
            </div>

            <div class="params">
                <h3>Материал</h3>
                <div>
                    <MaterialSelector :material-tags="materialTags" :materials="materials"
                        @material-selected="currentMaterial = $event" />
                </div>
            </div>

            <div class="params results">
                <h3>Результат</h3>

                <div>
                    <p>Материал: <span v-text="currentMaterial.displayname"></span>: <strong><span
                                v-text="currentMaterial.price"></span> ₽ / м. кв.</strong></p>
                    <p>Площадь:
                        <strong v-text="m_sq_count + 'кв. м.'"></strong>
                    </p>
                    <p>Индивидуальный дизайн:
                        <strong v-text="payload.price + ' ₽'"></strong>
                    </p>
                </div>
                <div class="price-section">
                    <h3>
                        Итоговая цена:
                        <span class="price" v-text="price + ' ₽'"></span>
                    </h3>
                    <button>Заказать</button>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import Navbar from '../../components/base/Navbar.vue'
import Breadcrumbs from '../../components/base/Breadcrumbs.vue'
import * as API from '../../assets/js/api'
import MaterialSelector from '@/components/MaterialSelector.vue'

export default {
    name: 'App',
    components: {
        Navbar,
        Breadcrumbs,
        MaterialSelector
    },
    data() {
        return {
            materialTags: API.parsejson("material_tags"),
            materials: API.parsejson("materials"),
            payload: API.parsejson("constructor_payload"),
            imgUrl: "https://i.scdn.co/image/ab67616d00001e02c3cf781fc4bea0a3d6fe1f92",

            wallHeight: 2.5,
            wallWidth: 6,

            imgSize: 1.0,
            imgRotate: 1.0,
            imgX: 1.0,
            imgY: 1.0,

            vpX: 1.0,
            vpY: 1.0,

            currentMaterial: {},
        }
    },
    computed: {
        m_sq_count: function() {
            return this.wallHeight * this.wallWidth;
        },
        price: function () {
            return (this.m_sq_count * this.currentMaterial.price) + this.payload.price;
        },
        vpColumnWidth: function () {
            return 100 / Math.max(1,this.wallWidth);
        },
        vpColumnCount: function () {
            return Math.floor(this.wallWidth);
        },
        autoCalcViewportWidthHeight: function() {
            console.log('autocalc')
            let h = this.wallWidth + this.wallHeight;
            this.calcViewportWidthHeight();
        }
    },
    methods: {
        scrollWidth(event) {
            let d = event.deltaY / -100;
            if (this.wallWidth <= 1.0 && d < 0) {
                return;
            }
            this.wallWidth += d;
            this.calcViewportWidthHeight();
        },
        scrollHeight(event) {
            let d = event.deltaY / -100;
            if (this.wallHeight <= 1.0 && d < 0) {
                return;
            }
            this.wallHeight += d;
            this.calcViewportWidthHeight();
        },
        calcViewportWidthHeight: function () {
            let x = 1.0;
            let y = 1.0;

            let wallY = this.wallHeight;
            let wallX = this.wallWidth;

            let wrong = false;
            if (wallX < 1) {
                this.wallWidth = 1;
                wrong = true;
            }
            if (wallY < 1) {
                this.wallHeight = 1;
                wrong = true;
            }
            if (wrong) {
                return;
            }

            let cx = 1.0;
            let cy = 1.0;
            let el = document.getElementById("viewport-wrapper");
            if (el != null) {
                cx = el.clientWidth;
                cy = el.clientHeight;
            }

            if (wallX > wallY) {
                x = 1.0;
                y = (1 / (wallX/wallY));
            }
            else if (wallY > wallX) {
                y = 1.0;
                x = (1 / (wallY/wallX));
            }

            if (cx > cy) {
                x *= (cy/cx);
            } else if (cy > cx) {
                y *= (cx/cy);
            }

            let s = 1.0;
            if (x > 1.0) {
                s = x/y;
            } else if (y > 1.0) {
                s = y/x;
            }

            let d = 0.0;
            if (x > y && x < 1.0) {
                d = 1.0 - x;
            } else if (y > x && y < 1.0) {
                d = 1.0 - y;
            }
            x += d;
            y += d;

            this.vpX = (x * s * 100);
            this.vpY = (y * s * 100);
        },
    },
    created: function () {
        this.currentMaterial = this.materials[0];
        this.imgUrl = "/constructor/image/"+this.payload.hash;
        setTimeout(() => {
            let vp = document.getElementById("viewport");
            vp.style.backgroundImage = `url("${this.imgUrl}")`;
            this.calcViewportWidthHeight();
        }, 300);
        setInterval(() => {
            this.calcViewportWidthHeight();
        }, 1000);
    }
}
</script>


<style lang="scss">
#app {
    flex: 1;
    display: flex;
    flex-direction: column;
}

.viewport-wrapper {
    display: flex;
    justify-content: center;
    align-items: center;
    grid-area: viewport;
    background-color: var(--main-color-2);
    background-image: url("../../assets/img/transparency.png");
    background-repeat: repeat;
    background-size: 5%;
    // padding: 10px;

        .viewport {
            flex-direction: row;
            position: relative;
            background-repeat: repeat;
            box-shadow: 0 0 15px #0000003d;
    
            
    
            .columns-preview {
                display: flex;
                width: 100%;
                height: 100%;
    
                .column {
                    height: 100%;
                    border-right: 1px dotted #c7c7c7;
                    border-left: 1px dotted #2b2b2b;
                }
            }
        }

}


.params {
    background-color: var(--main-color-1);

    display: flex;
    flex-direction: column;
    gap: 10px;
    padding: 15px;

    div {
        p {
            margin: 3px 0;
        }
    }
}

.results {
    display: grid;
    grid-template-rows: auto 1fr auto;
}

.price-section {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.price {
    color: var(--text-color-2);
}

.content {
    display: grid;
    grid-template-rows: 60% auto;
    grid-template-columns: 75% auto;
    grid-template-areas:
        "viewport params"
        "p p"
    ;
}


.content-wrapper {
    flex: 1;
}
</style>