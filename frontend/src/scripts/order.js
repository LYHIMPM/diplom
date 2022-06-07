import "../styles/profile.scss";
import "../styles/order.scss";
import {parsejson} from '../scripts/main';

import * as Vue from 'vue/dist/vue.esm-browser';

const app = Vue.createApp({
    compilerOptions: {
        delimiters: ["[[", "]]"]
    },
    data() {
        return {
            order: parsejson("order"),
        }
    },
    methods: {
    }
});
app.mount("#content");