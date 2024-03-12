<template>
      <v-dialog v-model="dialog" persistent width="auto">

        <template v-slot:activator="{ props }">
          <v-btn v-bind="props" variant="tonal" rounded :loading="loading" @click="this.loading = true">
            Submit
          </v-btn>
        </template>

        <v-card class="bg-grey-darken-3">
            <v-card-title>
                Are you sure you want to submit your answers?
            </v-card-title>

            <v-card-text class="pa-4">
                Please confrim your submission.
            </v-card-text>
         
            <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="red-darken-1" variant="tonal" @click="ClosePrompt">
                    Don't Submit
                </v-btn>
                
                <v-btn color="green-darken-1" variant="tonal" @click="Finish">
                    Submit
                </v-btn>
          </v-card-actions>
        </v-card>

      </v-dialog>
</template>

<script>
export default{
      data () {
        return {
          dialog: false,
          loading: false,
        }
      },
      methods: {
        ClosePrompt () {
          this.dialog = false
          this.loading = false
        },
        Finish: function() {
          this.$emit('Submit')
          this.$router.push('/end');
        }
      },
}
</script>