<template>
<div class="accounting-wrapper">

    <h3>Отчёты</h3>

    <div class="btns">
        <div>
            <button @click="createReport">Создать отчёт</button>
            <img class="loading-creating-report" v-if="loading_creating" src="../../../assets/img/loading.gif" alt="" />
        </div>
    </div>

    <p>Существующие отчёты:</p>
    <div class="reports-list">
        <img class="loading" v-if="loading_reports" src="../../../assets/img/loading.gif" alt="" />
        <template v-for="reportname in reports">
            <div class="report">
                <a :href="'/report/'+reportname" v-text="reportname"></a>
                <p @click="deleteReport(reportname)" class="red">Удалить</p>
            </div>
        </template>
        <p v-if="reports_list_loading_error" class="red">Ошибка. Не удалось загрузить список отчётов.</p>
        <template v-if="delete_modal_reportname != null">
            <AreYouSureDelete :reportname="delete_modal_reportname" @deleted="onDeleted($event)" @closeModal="delete_modal_reportname = null"/>
        </template>
    </div>
</div>
</template>

<script>

import * as API from '../../../assets/js/api'
import AreYouSureDelete from './AreYouSureDelete.vue';

export default {
    name: "Accounting",
    components: [AreYouSureDelete],
    data() {
        return {
            reports: [],
            loading_reports: true,
            loading_creating: false,
            delete_modal_reportname: null,
            reports_list_loading_error: false,
        };
    },
    methods: {
        loadReports() {
            this.reports = [];
            this.loading_reports = true;
            API.getReports().then(resp => {
                if (resp.response != undefined) {
                    this.reports = resp.response.slice().reverse();
                    this.loading_reports = false;
                    this.reports_list_loading_error = false;
                } else {
                    this.reports_list_loading_error = true;
                }
            });
        },
        createReport() {
            this.loading_creating = true;
            API.createReport().then(data => {
                if (data.response != undefined) {
                    this.reports.unshift(data.response);
                    this.loading_creating = false;
                }
            });
        },
        onDeleted(event) {
            this.loadReports();
        },
        deleteReport(report) {
            this.delete_modal_reportname = report;
        },
        closeAccountingReportDeleteModal() {
            this.delete_modal_reportname = null;
        },
    },
    created() {
        this.loadReports();
    },
    components: { AreYouSureDelete }
}
</script>
<style lang="scss">
.accounting-wrapper {
    display: flex;
    flex-direction: column;
    gap: 10px;
    padding: 20px;
}
p {
    margin: 10px 0;
}
.reports-list {
    border-radius: 5px;
    border: 1px solid var(--very-pale);
    padding: 10px;
    background-color: var(--main-color-2);
    display: flex;
    flex-direction: column;
    gap: 8px;

    .report {
        display: flex;
        gap: 15px;

        p {
            cursor: pointer;
            text-decoration: underline;
        }
    }
}

.btns {
    display: flex;
    div {
        display: flex;
        gap: 10px;
        img {
            width: 30px;
            height: 30px;
        }
    }
}

.loading {
    width: 100px;
    height: 100px;
}



</style>