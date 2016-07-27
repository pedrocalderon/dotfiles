require('./phoenix_scripts/windowPosition.js')
require('./phoenix_scripts/screenFocus.js')

var handler = new Key('t', ['ctrl', 'shift'], function() {
  log(Mouse.location())
})

