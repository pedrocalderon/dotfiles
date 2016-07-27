require('./phoenix_scripts/scanner.js')

var windowRegistry = {}

var alphakeys = 'qwertyuiopasdfghjklzxcvbnm'.split('')
function isAphaChar(char) {
  return alphakeys.indexOf(char) !== -1
}

function getCurrentWindow() {
  return Window.all().filter(function(w) {
    return mouseIsOverWindow(w) && w.isVisible()
  })[0]
}

var modKeys = ['ctrl', 'alt']

var markWindowHandler = new Key('m', modKeys, function() {
  var markWindowScanner = new Scanner()
  markWindowScanner.scan(function(key) {
    if (isAphaChar(key)) {
      windowRegistry[key] = getCurrentWindow()
    } else {
      Phoenix.notify('Registry key must be a char')
    }
  })
})

var gotoWindowHandler = new Key('g', modKeys, function() {
  var markWindowScanner = new Scanner()
  markWindowScanner.scan(function(key) {
    if (windowRegistry[key]) {
      windowRegistry[key].focus()
    } else {
      Phoenix.log('No window in this registry')
    }
  })
})

var handleClosedWindows = new Event('windowDidClose', function(windowClosed) {
  var keys = Object.keys(windowRegistry)
  keys.forEach(function(k) {
    if(windowRegistry[k].isEqual(windowClosed)) {
      delete windowRegistry[k]
      Phoenix.notify('Registry ' + k + ' has been deleted')
    }
  })
})