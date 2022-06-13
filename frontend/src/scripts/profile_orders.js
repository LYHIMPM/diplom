import "../styles/profile.scss";

import * as Vue from 'vue/dist/vue.esm-browser';
import { parsejson } from "./main";

let app = Vue.createApp({
    // compilerOptions: {
    //     delimiters: ["[[", "]]"]
    // },
    data() {
        return {
            orders: parsejson("orders"),
        }
    },
    methods: {
    }
});
app.mount("#app");