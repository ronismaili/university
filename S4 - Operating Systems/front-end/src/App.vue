<template>
  <v-app>
    <v-main>
      <router-view :StdID="ID" :ExamID="ExamID" @login="Login"></router-view>
    </v-main>
  </v-app>
</template>

<script>

export default {
  name: 'App',

  data: () => ({
    ExamID: '',
    ID:'',
  }),
  methods: {
    Login(num1, num2) {
      this.ID = num1;
      this.ExamID = num2;
    }
  }
}
</script>
