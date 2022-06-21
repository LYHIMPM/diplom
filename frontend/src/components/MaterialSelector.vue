<template lang="">
    <div class="material-select">
        <div class="container-h-1 material-tags-container">
            <template v-for="mtag in materialTags">
                <div class="material-tag"
                    :class="{ 'active': selected_mat_tags.includes(mtag.id) }"
                    @click="toggle_mat_tag_selection(mtag.id)">
                    <p v-text="mtag.displayname"></p>
                </div>
            </template>
        </div>

        <div class="container-h-1 materials-container">
            <template v-for="mat in materials_by_params">
                <div class="material-entry"
                    :class="{ 'active': current_material.id == mat.id }"
                    @click="sel_mat(mat)">
                    <img :src="mat.image_url" alt="">
                    <p v-text="mat.displayname"></p>
                </div>

            </template>
            <p v-if="materials_by_params.length == 0">Не найдено материалов по выбранным
                параметрам</p>
        </div>
    </div>
</template>
<script>
export default {
    props: ["materialTags", "materials"],
    emits: ["materialSelected"],
    data() {
        return {
            current_material: this.materials[0],
            selected_mat_tags: [],
        }
    },
    computed: {
        materials_by_params: function () {
            let materials = this.materials;
            if (this.selected_mat_tags.length == 0) {
                return this.materials;
            }

            materials = this.materials.filter((mat) => {
                for (let i = 0; i < this.selected_mat_tags.length; i++) {
                    const tag = this.selected_mat_tags[i];
                    if (!mat.tags.includes(tag)) {
                        return false;
                    }
                }
                return true;
            })

            return materials;
        },
    },
    methods: {
        sel_mat: function (mat) {
            this.current_material = mat;
            this.$emit("materialSelected", mat);
        },
        toggle_mat_tag_selection: function (tag_id) {
            if (this.selected_mat_tags.includes(tag_id)) {
                this.selected_mat_tags = this.selected_mat_tags.filter(function (value, index, arr) {
                    return value != tag_id;
                });
            } else {
                this.selected_mat_tags.push(tag_id);
            }
        },
    },
    created: function() {
        console.log(this.materials);
        console.log(this.materialTags);
        this.current_material = this.materials[0];
        this.$emit("materialSelected", this.current_material);
    }
}
</script>
<style lang="scss">
.material-select {
    display: flex;
    gap: 10px;
    flex-direction: column;
}

.material-tag {
    background-color: var(--main-color-1);
    border: 1px solid var(--main-color-3);
    padding: 2px 8px;
    border-radius: 1.5em;
    user-select: none;
    cursor: pointer;
}

.material-tag p {
    text-transform: lowercase;
}

.material-tag:hover {
    border: 1px solid var(--second-color-3-hover);
}

.material-tag.active {
    border: 1px solid var(--second-color-3);
}

.material-entry {
    --mat-entry-width: 100px;
    width: var(--mat-entry-width);
    border-radius: 10px;
    cursor: pointer;
}

.material-entry.active {
    outline: 1px solid var(--second-color-3);
}

.material-entry img {
    border-radius: 10px;
    width: var(--mat-entry-width);
    height: var(--mat-entry-width);
}

.material-entry p {
    margin: 0;
}

.material-entry p {
    color: var(--text-color-2);
    font-size: 0.8em;
    word-wrap: normal;
    text-align: center;
}
</style>