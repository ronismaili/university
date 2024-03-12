<template>

<v-layout class="h-100" style="background-color: aliceblue; z-index: 10;">
  <Transition>
  <v-container fluid v-show="ShowNote" style="position: absolute; left: 0; top: 0;  z-index: 1000; background-color: #000d;" class="h-100">
    <Note :Exam="this.Exam" @close="this.ShowNote = false"/>
  </v-container>
  </Transition>

  <NavBar class="bg-grey-darken-3" @ChangeQuestion="ChangeQuestion" :Num="this.Exam.questionsNotesMarks.length" :ID="this.StdID"/>
    
  <v-main>

    <v-container fluid class="h-100 pa-0 ma-0">

      <v-row class="bg-grey-darken-3 pa-0 ma-0">
        <v-col align="center" class="v-col-1 offset-0">
          <v-btn variant="tonal" rounded @click="this.ShowNote = true">
            Note
          </v-btn>
        </v-col>
        <v-col align="center" class="v-col-2 offset-4">
          <Counter :TimeLeft="TimeLeft" :StartCountdown="StartCountdown" @SyncCountdown="CalcTimeTaken"/>
        </v-col>
        <v-col align="center" class="v-col-1 offset-3">
          <v-btn :disabled="CompileDisabled[this.QuestionNumber - 1]" :loading="Compiling" variant="tonal" @click="SendToCompiler" rounded>
            Compile ({{ this.Exam.triesAllowed - Compiles[this.QuestionNumber - 1]}})
          </v-btn>
        </v-col>
        <v-col align="center" class="v-col-1 offset-0">
          <SubmitButton @Submit="SubmitExam = true"/>
        </v-col>
      </v-row>

      <v-row class="h-75 pa-5 ma-0 bg-blue-grey-darken-4" fluid>
        <v-col class="pa-4 ma-0 bg-blue-grey-darken-3 rounded-xl" v-show="ShowQuestion">
          <QuestionItem :Questions="this.Exam.questionsNotesMarks" :QuestionNumber="QuestionNumber" @CloseQuestion="ToggleQuestion"/>
        </v-col>
        <v-col class="h-100 pa-0" fluid>
          <Editor :Compiling="Compiling" :SubmitExam="SubmitExam" :QuestionNumber="QuestionNumber" :ExamID="ExamID" :StdID="StdID" :TimeTaken="TimeTaken" @CompileFinish="FinishCompiling"/>
        </v-col>
      </v-row>

      <v-row class="h-100 pa-0 ma-0" fluid>
        <Console :Error="Error" v-show="true"/> <!-- THIS COULD CAUSE AN UNNECESSARY SCROLLBAR -->
      </v-row>

    </v-container>
    
  </v-main>
    
</v-layout>
    
</template>


<script>
import { defineComponent } from 'vue';
import NavBar from "../components/NavBar.vue"
import Counter from "../components/CounterItem.vue"
import Editor from "../components/CodeEditor.vue"
import Console from "../components/ConsoleOutput.vue"
import Note from "../components/ProfessorNote.vue"
import QuestionItem from "../components/QuestionItem.vue"
import SubmitButton from "../components/SubmitButton.vue"
import axios from 'axios'

export default defineComponent({
    name: 'StudentPageView',
  
    components: {
        NavBar,
        Counter,
        Editor,
        Console,
        Note,
        QuestionItem,
        SubmitButton
    },

    data() {
        return {
            ShowQuestion: true,
            ShowNote: true,
            Compiling: false,
            SubmitExam: false,
            QuestionNumber: 1,
            CompileDisabled: [false, false, false, false, false],
            Compiles: [],
            StartCountdown: false,
            Exam: {
              questionsNotesMarks: [{}],
              studentsIds: []
            },
            Error: "Awaiting first compile...",
            TimeTaken: 0,
            TimeLeft: 0
        }
    },

    props: ['StdID', 'ExamID'],

    methods: {
        ToggleQuestion() {
          this.ShowQuestion = !this.ShowQuestion
        },
        ChangeQuestion(num) {
          this.QuestionNumber = num
          this.ShowQuestion = true
        },
        SendToCompiler() {
          this.Compiles[this.QuestionNumber - 1]++
          if (this.Compiles[this.QuestionNumber - 1] == this.Exam.triesAllowed) {
            this.CompileDisabled[this.QuestionNumber - 1] = true
          }
          this.Compiling = true
        },
        FinishCompiling(error) {
          this.Error=error
          this.Compiling = false
        },
        CalcTimeTaken(num) {
          this.TimeTaken = this.TimeLeft - num
        },
    },

    beforeCreate() {
      axios.get('http://192.168.12.1:8000/api/getExam?Exam_Id=' + this.ExamID)
      .then((response)=>{
        this.Exam = response.data.examData; this.TimeLeft = response.data.timeLeft;
        for (let i = 0; i < this.Exam.questionsNotesMarks.length; i++) {
          this.Compiles[i] = 0
        }
      })
    }
});
</script>

<style scoped>
.v-enter-active,
.v-leave-active {
  transition: opacity 0.5s ease;
}

.v-enter-from,
.v-leave-to {
  opacity: 0;
}
</style>