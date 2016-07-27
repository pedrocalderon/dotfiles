require('./phoenix_scripts/windowPosition.js')
require('./phoenix_scripts/screenFocus.js')
require('./phoenix_scripts/markWindows.js')
require('./phoenix_scripts/time.js')

require('./phoenix_scripts/scanner.js')

var handler = new Key('t', ['ctrl', 'shift'], function() {
  var simplescan = new Scanner()
  simplescan.scanln()
})

