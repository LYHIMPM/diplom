import * as Vue from 'vue/dist/vue.esm-browser';
import {parsejson} from '../scripts/main';

let breadcrumbs = Vue.createApp({
    compilerOptions: {
        delimiters: ["[[", "]]"]
    },
    data() {
        return {
            breadcrumbs: parsejson("breadcrumbs-payload"),
        }
    }
});
breadcrumbs.mount("#breadcrumbs");