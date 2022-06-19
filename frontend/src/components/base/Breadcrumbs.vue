<template>
<div class="breadcrumbs" id="breadcrumbs">
    <template v-for="bcr in breadcrumbs">
        <a :href="bcr[1]" v-text="bcr[0]"></a>
        <p v-if="bcr[1] != breadcrumbs[breadcrumbs.length-1][1]">/</p>
    </template>
</div>
</template>

<script>
import {parsejson} from '../../assets/js/utils';

export default {
    name: "Breadcrumbs",
    data() {
        return {
            breadcrumbs: parsejson("breadcrumbs-payload"),
        }
    }
}
</script>