<template>

    <div class="modal-bg" @click.self="$emit('closeModal')">
        <div class="modal delete-modal">
            <template v-if="ok">
                <div>
                    <h3>Вы точно хотите удалить отчёт <br><span class="reportname" v-text="reportname"></span>?</h3>
                </div>
                <div>
                    <button class="red" @click="deleteRep">Удалить</button>
                </div>
            </template>
            <template v-else>
                <div>
                    <p class="red">Что-то пошло не так. Удалить <span v-text="reportname"></span> не удалось!</p>
                </div>
                <div>
                    <button @click="$emit('closeModal')">Закрыть</button>
                </div>
            </template>
        </div>
    </div>

</template>

<script>
import { deleteReport } from '../../../assets/js/api'

export default {
    name: 'AreYouSureDelete',
    emits: ['deleted', 'closeModal'],
    props: ['reportname'],
    data() {
        return {
            ok: true
        }
    },
    methods: {
        deleteRep() {
            deleteReport(this.reportname).then(resp => {
                if (resp.response != undefined) {
                    this.$emit("deleted", resp.response);
                    this.$emit("closeModal", resp.response);
                } else {
                    this.ok = false;
                }
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
    max-width: 400px;

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