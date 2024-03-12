<template>
    <v-navigation-drawer expand-on-hover rail>
        
      <v-list>
          <v-list-item prepend-avatar="./student_icon.jpg" title="Ron Ismaili" :subtitle="this.ID">
          </v-list-item>
        </v-list>
        
        <v-divider></v-divider>

        <v-list density="compact" nav>
          <v-list-item prepend-icon="mdi-star" v-for="n in parseInt(Num)" :key="n" :title="`Question ` + n" @click="this.$emit('ChangeQuestion', n)"></v-list-item>
        </v-list>
        
        <v-divider></v-divider>

      </v-navigation-drawer>
</template>

<script>
  export default {
    props: ['ID', 'Num']
  }
</script>