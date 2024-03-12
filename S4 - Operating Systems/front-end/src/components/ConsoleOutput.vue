<template>
    <v-container fluid class="pa-2 ma-0 temp">
        <p class="console-text-error" :class="{'console-text-awaiting': Error === 'Awaiting first compile...', 'console-text-success': Error === 'Successful Compile'}">{{ Error }}</p>
</v-container>
</template>

<script>
export default {
    props:['Error']
}
</script>

<style scoped>
.temp {
    overflow-y: auto;
    max-height: 19.9vh;
    background-color: #0d0f17;
    border-top: 5px solid #424242;
}
.console-text-awaiting {
    color: white !important; 
}
.console-text-success {
    color: #04ff00 !important;
}
.console-text-error {
    color: red;
}
</style>