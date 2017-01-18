function toTwoDigits(num) {
  var str = num.toString()
  return str.length === 1 ? '0' + str : str
}

function calculateTimeString(time) {
  var seconds = time % 60
  var minutes = (time - seconds) / 60

  return toTwoDigits(minutes) + ':' + toTwoDigits(seconds)
}


function Pomodoro() {
  // start static properties
  this.pomodorosBeforeBreak = 2//5
  this.pomodoroLength = 1//25
  this.pauseLenght = 1//5
  this.breakLenght = 1//15
  // end static properties

  this.status = null
  this.timer = null
  this.repetitions = 0
  this.timeInSeconds = 0
  this.intervalHandler = null
  this.modal = null
  this.showing = false
}

Pomodoro.prototype.start = function() {
  var duration = this.pomodoroLength * 60
  var incrementTimer = this.incrementTimer.bind(this)

  this.timer = new Timer(duration, false, this.endPomodoro.bind(this))
  this.status = 'Working'

  this.timeInSeconds = 0
  this.intervalHandler = setInterval(incrementTimer, 1000)
  this.display('Starting pomodoro', 2)
}

Pomodoro.prototype.pause = function() {
  var duration = this.pauseLenght * 60
  var incrementTimer = this.incrementTimer.bind(this)

  this.timer = new Timer(duration, false, this.start.bind(this))
  this.status = 'Pause'

  this.timeInSeconds = 0
  this.intervalHandler = setInterval(incrementTimer, 1000)
  this.display()
}

Pomodoro.prototype.startBreak = function() {
  var duration = this.breakLenght * 60
  var incrementTimer = this.incrementTimer.bind(this)

  this.timer = new Timer(duration, false, this.start.bind(this))
  this.status = 'Break'

  this.timeInSeconds = 0
  this.intervalHandler = setInterval(incrementTimer, 1000)
  this.display()
}

Pomodoro.prototype.endPomodoro = function() {
  if (this.intervalHandler) clearInterval(this.intervalHandler)

  this.incrementPomodoros()
  if (this.repetitions >= this.pomodorosBeforeBreak) {
    this.startBreak()
  } else {
    this.pause()
  }
}

Pomodoro.prototype.incrementPomodoros = function() {
  Phoenix.log(this.repetitions)
  this.repetitions += this.repetitions
}

Pomodoro.prototype.incrementTimer = function() {
  Phoenix.log(this.timeInSeconds)
  this.timeInSeconds += this.timeInSeconds
}

Pomodoro.prototype.stop = function() {
  if (this.timer) this.timer.stop()
  if (this.intervalHandler) clearInterval(this.intervalHandler)

  this.status = null
  this.timer = null
  this.intervalHandler = null
  this.repetitions = 0
  this.timeInSeconds = 0
  this.modal = null
  this.showing = false
}

Pomodoro.prototype.getTimerMsg = function() {
  return this.status + ': ' + calculateTimeString(this.timeInSeconds)
}

Pomodoro.prototype.display = function(msg, duration) {
  var getTimerMsg = this.getTimerMsg.bind(this)
  var modal = this.modal

  modal = new Modal()

  if (duration) modal.duration = duration
  if (msg) {
    modal.message = msg
  } else {
    modal.message = getTimerMsg()
    setInterval(
      function() {
        modal.message = getTimerMsg()
      },
      1000
    )
  }

  modal.show()
  this.showing = true
}

Pomodoro.prototype.hide = function() {
  if (this.modal) {
    this.modal.close()
    this.modal = null
    this.showing = false
  }
}

Pomodoro.prototype.toggle = function() {
  if (this.showing) {
    this.hide()
  } else {
    this.display()
  }
}

var pomodoroInstance = new Pomodoro()
var pomodoroHandlers = {
  start: new Key('p', ['ctrl', 'alt', 'cmd'], function() { pomodoroInstance.start()}),
  toggle: new Key('p', ['ctrl', 'alt'], function() { pomodoroInstance.toggle() })
}
