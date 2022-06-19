<template>

    <div class="content-wrapper" id="content">
        <Navbar />
        <Breadcrumbs />
        <div id="app" class="store-content">
            <div class="tags">
                <template v-for="tag in all_tags">
                    <input v-model="filter_tags" @change="loadEntries" type="checkbox" :id="'tag-' + tag.tag"
                        :value="tag.tag" class="tag">
                    <label :for="'tag-' + tag.tag" v-text="tag.displaytag" class="tag"></label>
                </template>
            </div>

            <div class="content">
                <div class="main-area">
                    <div class="store-filters round">
                        <div class="store-filters-title-container">
                            <h3>Фильтр</h3>
                            <a href="/premade">Сбросить</a>
                        </div>

                        <div class="filter-category">
                            <input style="width: 100%;" placeholder="Поиск..." v-model="search"
                                autocomplete="off" type="numeric">
                        </div>

                        <div class="filter-category">
                            <h4>Цена, ₽</h4>
                            <p class="price-filter">
                                <input v-model="price_from" name="price_from" id="price_from" autocomplete="off"
                                    type="numeric" pattern="[0-9&thinsp;]*">
                                <span style="text-align: center;">-</span>
                                <input v-model="price_to" name="price_to" id="price_to" autocomplete="off"
                                    type="numeric" pattern="[0-9&thinsp;]*">
                            </p>
                        </div>

                        <div class="filter-category">
                            <h4>Особенности</h4>
                            <p><input v-model="filter_full_picture" type="checkbox" name="full_pic" id="full_pic"><label
                                    for="full_pic">Цельное изображение</label></p>
                        </div>

                        <button @click="loadEntries" style="width: 100%;">Применить фильтры</button>

                    </div>
                    <div class="store-elements-container">

                        <template v-for="entry in entries">
                            <a :href="'/premade/' + entry.id" class="wallpaper-entry">
                                <img class="entry-img" :src="entry.main_image" alt="">
                                <div class="entry-info-container">
                                    <p class="entry-name"><span v-text="entry.name"> </span><span class="pale unsel"
                                            style="margin: 0 6px;"></span></p>
                                    <p class="entry-price" v-text="entry.price + ' ₽'"></p>
                                    <p class="entry-description" v-text="entry.description"></p>

                                    <div class="entry-tags">
                                        <template v-for="tag in entry.tags">
                                            <p v-text="tag.displaytag"></p>
                                        </template>
                                    </div>
                                </div>
                            </a>
                        </template>

                    </div>
                </div>
            </div>

            <div class="pagination">
                <template v-for="p in pages_total">
                    <p :class="{ 'current-page': current_page == p - 1 }" class="page-link-btn"
                        @click="setPage(p-1)" v-text="p"></p>
                </template>
            </div>
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
            entries: [],
            all_tags:[],
            entries_per_page: 6,
            pages_total: 1,
            current_page: 0,

            price_from: 0,
            price_to: 0,
            materials: [],
            filter_tags: [],
            filter_full_picture: false,
            search: "",

            page_buttons_count: 5,
        }
    },
    methods: {
        setPage: function(page) {
            console.log("setting page to " + page)
            this.current_page = page;
            this.loadEntries();
        },
        loadEntries: function() {
            API.getPremade(
                this.current_page, this.price_from, this.price_to,
                this.filter_full_picture, this.search, this.filter_tags
            ).then((data) => {
                console.log(data);
                data = data.response;
                this.all_tags = data.tags;
                this.entries = data.entries;
                this.entries_per_page = data.entries_per_page;
                this.pages_total = data.pages_total;
            });
        }
    },

    created: function () {
        this.loadEntries();
    }
}
</script>
