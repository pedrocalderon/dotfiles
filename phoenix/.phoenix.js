require('./phoenix_scripts/windowPosition.js')
require('./phoenix_scripts/screenFocus.js')
require('./phoenix_scripts/markWindows.js')
require('./phoenix_scripts/time.js')
//require('./phoenix_scripts/pomodoro.js')

require('./phoenix_scripts/scanner.js')

var cnt = 0
var modal = new Modal()


var handler = new Key('t', ['ctrl', 'shift'], function() {
  modal.show()
  var int = setInterval(
    function() {
      cnt ++
      modal.message = calculateTimeString(cnt)
    },
    1000
  )
})

var handler1 = new Key('q', ['ctrl', 'shift'], function() {
  modal.close()
})

