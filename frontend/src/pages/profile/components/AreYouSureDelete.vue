<template>

<div class="modal-bg" @click.self="$emit('closeModal')">
    <div class="modal delete-modal">
        <div>
            <h3>Вы точно хотите удалить отчёт <br><span class="reportname" v-text="reportname"></span>?</h3>
            <h5 v-if="wrong">Данные неверны</h5>
        </div>
        <div>
            <button class="red" @click="deleteRep">Удалить</button>
        </div>
    </div>
</div>

</template>

<script>
import {deleteReport} from '../../../assets/js/api'

export default {
    name: 'AreYouSureDelete',
    emits: ['deleted', 'closeModal'],
    props: ['reportname'],
    methods: {
        deleteRep() {
            deleteReport(this.name).then(resp => {
                console.log(resp);
                this.$emit("deleted");
            });
        },
    }
}
</script>


<style lang="scss">
.delete-modal {
    .reportname {
        color: var(--text-color-2);
    }
    background: #fff;
    padding: 50px;
    border: 1px solid var(--very-pale);
    border-radius: 15px;
    box-shadow: 5px 5px 50px #00000031;

    display: flex;
    flex-direction: column;
    gap: 10px;

    div {
        display: flex;
        flex-direction: column;
        a {
            margin-top: 10px;
        }
    }

    h2 {
        text-align: center;
    }
}
</style>