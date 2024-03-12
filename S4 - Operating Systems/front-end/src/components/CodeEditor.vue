<template>
    <v-container fluid class="pa-5 ma-0 pt-0">
      <v-textarea v-model="EditorList[QuestionNumber - 1]" class="bg-blue-grey-darken-3 rounded-xl pa-5" color="black" variant="outlined" label="Code editor" rows="23" no-resize hide-details>
      </v-textarea>
    </v-container>
</template>

<script>
import axios from "axios"
export default {
  data() {
    return {
      EditorList: [],
      Code: ''
    }
  },
  props: ['QuestionNumber', 'SubmitExam', 'Compiling', 'ExamID', 'StdID', 'SubmitQuestion', 'TimeTaken'],
  watch: {
    Compiling: function() {
      if(this.EditorList[this.QuestionNumber - 1] === undefined) {
        this.EditorList[this.QuestionNumber - 1] = '';
      }
      axios.post('http://192.168.12.1:8000/api/compileTest', {
        Exam_Id: this.ExamID,
        Std_Id: this.StdID,
        Q_Num: this.QuestionNumber,
        Code: this.EditorList[this.QuestionNumber - 1]
      }).then((response) => {
        this.$emit('CompileFinish', response.data.Response)
      })
    },
    SubmitExam: function() {
      for (let i = 0; i < this.EditorList.length; i++) {
        if(this.EditorList[i] == null) {
          this.Code += '`'
        } else {
          this.Code += (JSON.stringify(this.EditorList[i]) + '`')
        }
      }
      this.Code = this.Code.replaceAll('"', '')
      this.Code = this.Code.substring(0, this.Code.length - 1)
      axios.post('http://192.168.12.1:8000/api/submitExam', {
        Exam_Id: this.ExamID,
        Std_Id: this.StdID,
        Sub_time: this.TimeTaken,
        Code_Ans: this.Code
      })
      .catch((error) => {console.log(error)})
    }
  }
}
</script>