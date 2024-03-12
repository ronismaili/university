<template>
    <div class="text-center">
        <v-chip variant="tonal" size="large" class="ml-13 text-center" :class="{'text-red': this.CountDown <600}">
            {{ hours_string }} : {{ minutes_string }} : {{ seconds_string }}
        </v-chip>
    </div>
</template>
 
<script>
    export default {
        data () {
            return {
                CountDown: 10,
                seconds: 0,
                minutes: 0,
                hours: 0,
                seconds_string: '',
                minutes_string: '',
                hours_string: ''
            }
        },
        props: ['StartCountdown', 'TimeLeft'],
        methods: {
            countDownTimer () {
                if (this.CountDown > 0) {
                setTimeout(() => {
                    this.CountDown -= 1
                    this.countDownTimer()
                    this.$emit('SyncCountdown', this.CountDown)
                    this.seconds = this.CountDown % 60
                    this.minutes = ((this.CountDown - this.seconds) / 60) % 60
                    this.hours = ((this.CountDown - (this.minutes * 60) - this.seconds) / 3600)
                    this.hours_string = this.hours.toString().padStart(2, '0')
                    this.minutes_string = this.minutes.toString().padStart(2, '0')
                    this.seconds_string = this.seconds.toString().padStart(2, '0')
                    }, 1000)
                }
            }
        },
        watch: {
            TimeLeft: function() {
                this.CountDown = this.TimeLeft
                this.seconds = this.CountDown % 60
                this.minutes = ((this.CountDown - this.seconds) / 60) % 60
                this.hours = ((this.CountDown - (this.minutes * 60) - this.seconds) / 3600)
                this.hours_string = this.hours.toString().padStart(2, '0')
                this.minutes_string = this.minutes.toString().padStart(2, '0')
                this.seconds_string = this.seconds.toString().padStart(2, '0')
            }
        },
        created () {
            this.countDownTimer()
        }
    }
</script>