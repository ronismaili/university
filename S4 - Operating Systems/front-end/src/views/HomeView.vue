<template>
  <v-container fluid class="h-100 w-auto px-lg-16 Background">
    <v-row align="center" class="h-100 mx-lg-16 px-lg-16">
      <v-col align="center" class="rounded-lg hidden-md-and-up">
        <p class="text-red font-weight-bold text-h3">This app is not meant to be used with small devices, please use a larger device.</p>
      </v-col>
      <v-col align="center" class="v-col-4 offset-4 rounded-xl h-50 hidden-sm-and-down pa-10">
        <p class="text-white text-h4">XamDiv Login</p>
        <v-form @submit.prevent="Authenticate" class="py-8 h-100">
          <v-btn-toggle class="w-100 mb-8" v-model="UserType" mandatory>
              <v-btn text class="text-white rounded-pill mx-4" style="width: 40%; height: 100%;" value="Student">Student</v-btn>
              <v-btn text class="text-white rounded-pill mx-6" style="width: 40%; height: 100%;" value="Professor">Professor</v-btn>
          </v-btn-toggle>
          <v-text-field required v-model="ID" type="text" label="User ID" class="text-white" color="white">
            <template v-slot:prepend>
              <v-icon class="rounded-circle" icon="mdi-school" size="x-large"></v-icon>
            </template>
          </v-text-field>
          <v-text-field required v-model="ExamID" label="Exam ID" class="text-white" color="white" type="text" v-if="UserType === 'Student'">
            <template v-slot:prepend>
              <v-icon class="rounded-circle" icon="mdi-pound" size="x-large"></v-icon>
            </template>
          </v-text-field>
          <v-text-field required v-model="Password" label="Password" class="text-white" color="white" type="password" v-if="UserType === 'Professor'">
            <template v-slot:prepend>
              <v-icon class="rounded-circle" icon="mdi-lock" size="x-large"></v-icon>
            </template>
          </v-text-field>
          <v-btn type="Submit" elevation="8" class="rounded-pill text-lowercase text-white">login</v-btn>
        </v-form>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { defineComponent } from 'vue';
import { aliases, mdi } from 'vuetify/iconsets/mdi'
import axios from 'axios';

// Components


export default defineComponent({
  name: 'HomeView',
  icons: {
    defaultSet: 'mdi',
    aliases,
    sets: {
      mdi,
    },
  },
  data() {
    return {
      ExamID: '',
      ID:'',
      UserType: 'Student',
      Password: ''
    };
  },
  methods: {
    Authenticate: function() {
      if(this.ID != '') {
        if (this.UserType === 'Student') {
          if (this.ExamID != '') {
            axios.put('http://192.168.12.1:8000/api/Stdlogin?Std_Id=' + this.ID + '&Exam_Id=' + this.ExamID)
            .then((response) => {
              if (response.data.Response === 'Access granted') {
                this.$emit('login', this.ID, this.ExamID)
                this.$router.push('/Student');
              } else {
                alert(response.data.Response)
              }
            })
          } else {
            alert('Please enter the Exam ID')
          }
        } else {
          axios.get('http://192.168.12.1:8000/api/Proflogin?Prof_Id=' + this.ID + '&Pswd=' + this.Password)
          .then((response) => {
            if (response.data.Response === 'Access granted') {
              this.$router.push('/database');
            } else {
              alert(response.data.Response)
            }
          })
        }
      } else {
        alert('Please enter your ID')
      }
    },
  }
});
</script>

<style scoped>
  .v-container.Background {
    font-family: Roboto Mono;
    background: url(../assets/Login_Background.jpg);
    background-size: cover;
  }
  .v-col {
    background-color: #A08FFFF2;
  }
  .v-btn {
    background-color: #6B67C6;
    width: 25%;
  }
  .v-icon {
    width: 50px;
    height: 50px;
    color: white;
    background-color: #6B67C6;
  }
</style>