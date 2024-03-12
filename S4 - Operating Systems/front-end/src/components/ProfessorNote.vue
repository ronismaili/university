<template>
    <v-component fluid>
        <v-row align="center" class="h-100">
            <v-col align="center" class="v-col-4 offset-4 rounded-xl">
                    <p class="text-white text-h4 roni">Final Exam</p>  <!--text-h4 overwrites the font-family, that's why I added this class -Roni -->
                <v-container>
                    <v-row class="pa-2">
                        <v-col class="v-col-3 pr-0">
                            <v-card class="rounded-s-lg Title text-white" text="Professor" variant="tonal"></v-card>
                        </v-col>
                        <v-col class="v-col-9 pl-0">
                            <v-card class="rounded-e-lg" :text=this.Exam.professor variant="tonal"></v-card>
                        </v-col>
                    </v-row>
                    <v-row class="pa-2">
                        <v-col class="v-col-2 pr-0">
                            <v-card class="rounded-s-lg Title text-white" text="Course" variant="tonal"></v-card>
                        </v-col>
                        <v-col class="v-col-4 pl-0">
                            <v-card class="rounded-e-lg" :text=this.Exam.course variant="tonal"></v-card>
                        </v-col>
                        <v-col class="v-col-2 pr-0">
                            <v-card class="rounded-s-lg Title text-white" text="Date" variant="tonal"></v-card>
                        </v-col>
                        <v-col class="v-col-4 pl-0">
                            <v-card class="rounded-e-lg" :text=this.Exam.date variant="tonal"></v-card>
                        </v-col>
                    </v-row>
                    <v-row class="pa-2">
                        <v-col class="v-col-2 pr-0">
                            <v-card class="rounded-s-lg Title text-white" text="Marks" variant="tonal"></v-card>
                        </v-col>
                        <v-col class="v-col-4 pl-0">
                            <v-card class="rounded-e-lg" :text=this.Exam.marks variant="tonal"></v-card>
                        </v-col>
                        <v-col class="v-col-2 pr-0">
                            <v-card class="rounded-s-lg Title text-white" text="Time" variant="tonal"></v-card>
                        </v-col>
                        <v-col class="v-col-4 pl-0">
                            <v-card class="rounded-e-lg" :text="getTime()" variant="tonal"></v-card>
                        </v-col>
                    </v-row>
                    <v-row class="pa-2">
                        <v-col class="v-col-12">
                            <v-card class="rounded-lg pa-4" variant="tonal">
                                <P>NOTE</P>
                                <p>{{ this.Exam.note }}</p>
                            </v-card>
                        </v-col>
                    </v-row>
                    <v-row>
                        <v-col class="v-col-4 offset-4">
                            <v-btn style="width: 100px;" elevation="10" class="bg-green-darken-1 text-capitalize" @click="this.$emit('close')">Start</v-btn>
                        </v-col>
                    </v-row>
                </v-container>
            </v-col>
        </v-row>
    </v-component>
</template>

<script>
    export default {
        name: "ProfessorNote",
        props: ['Exam'],
        methods: {
            getTime() {
                return this.Exam.time + " minutes";
            }
        }
    }
</script>

<style scoped>
    * {
        font-family: Roboto Mono;
    }
    .v-col {
        background-color: #A08FFF;
        height: 65%;
    }
    .v-card {
        background-color: white;
        max-height: 150px;
    }
    .v-card.Title {
        background-color: #655fca;
    }
    .roni {
        font-family: Roboto Mono !important;
    }
</style>