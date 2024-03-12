<template>
    <v-container class="pa-5 ma-0 h-100">
        <v-row class="pa-0 ma-0">
            <v-col class="v-col-11 offset-0 pt-4 pl-0">
                <h2>Question {{ QuestionNumber }}</h2>
                <p>{{ Questions[num].M }} Pts.</p>
            </v-col>
            <v-col align="center" class="v-col-1 offset-0">
                <v-btn variant="tonal" rounded @click="this.$emit('CloseQuestion')">
                    <v-icon>mdi-close</v-icon>
                </v-btn>
            </v-col>
            <v-divider class="border-opacity-100"></v-divider>
        </v-row>
        <v-row class="h-50">
            <v-col>
                    {{ Questions[num].Q }}
            </v-col>
        </v-row>
        <v-row class="h-25">
            <v-col>
                <v-divider class="border-opacity-100"></v-divider>
                {{ Questions[num].N }}
            </v-col>
        </v-row>
    </v-container>
</template>

<script>
export default {
    props: ['QuestionNumber', 'Questions'],
    data() {
        return {
            num: 0,
            MarkList: [
                5, 10, 15, 20, 25
            ]
        }
    },
    watch: {
        QuestionNumber: function(newval) {
            this.num = newval - 1
        }
    }
}
</script>