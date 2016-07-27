function log(obj) {
  Phoenix.log(JSON.stringify(obj))
}

function pointIsInFrame(frame, point) {
  var frameXMin = frame.x
  var frameXMax = frame.x + frame.width
  var frameYMin = frame.y
  var frameYMax = frame.y + frame.height

  var isInXRange = frameXMin <= point.x && point.x <= frameXMax
  var isInYRange = frameYMin <= point.y && point.y <= frameYMax

  return isInXRange && isInYRange
}

function mouseIsInScreen(screen) {
  var frame = screen.frameInRectangle()
  var mouse = Mouse.location()
  return pointIsInFrame(frame, mouse)
}

function getCurrentScreen() {
  var mouse = Mouse.location()
  return Screen.all().filter(function(s) {
    return mouseIsInScreen(s)
  })[0]
}

function screenCenter(screen) {
  var frame = screen.frameInRectangle()
  return {
    x: frame.x + frame.width/2,
    y: frame.y + frame.height/2,
  }
}

function pointsDistance(a, b) {
  xsqare =  Math.pow((b.x - a.x), 2)
  ysqare =  Math.pow((b.y - a.y), 2)
  return Math.sqrt(xsqare + ysqare)
}

// we will return north/south/east/weast to follow the Window standard
// TODO: the neighbour dont consider the size of the screens, so the same screen
// may appear in more than one direction.
function screenNeighbours(screen) {
  var currentCenter = screenCenter(screen)
  var screens = Screen.all()
    .filter(function(s) {
      return s.identifier() !== screen.identifier()
    })
    .map(function(s) {
      var center = screenCenter(s)
      return {
        screen: s,
        center: center,
        distance: pointsDistance(currentCenter, center)
      }
    })

  var northScreens = screens.filter(function(s) {
    return s.center.y < currentCenter.y
  })
  var southScreens = screens.filter(function(s) {
    return s.center.y > currentCenter.y
  })
  var eastScreens = screens.filter(function(s) {
    return s.center.x > currentCenter.x
  })
  var weastScreens = screens.filter(function(s) {
    return s.center.x < currentCenter.x
  })

  var iteratee = function(screenObj) { return screenObj.distance }
  return {
    north: _.min(northScreens, iteratee).screen,
    south: _.min(southScreens, iteratee).screen,
    east: _.min(eastScreens, iteratee).screen,
    weast: _.min(weastScreens, iteratee).screen,
  }
}

function mouseIsOverWindow(window) {
  var frame = window.frame()
  var mouse = Mouse.location()
  return pointIsInFrame(frame, mouse)
}

function putMouseToScreenCenter(screen) {
  Mouse.move(screenCenter(screen))
}

function getCurrentWindow() {
  return Window.all().filter(function(w) {
    return mouseIsOverWindow(w) && w.isVisible()
  })[0]
}

function screenFocusAlert(screen) {
  if (!screen) screen = getCurrentScreen()

  var alertModal      = new Modal()
  alertModal.duration = 0.5
  alertModal.message  = 'AQUI'

  var screenFrame     = screen.frameInRectangle()
  var alertFrame      = alertModal.frame()

  alertModal.origin = screenCenter(screen)
  alertModal.show()

  return alertModal
}

function changeScreen(direction) {
  return function() {
    var screen = getCurrentScreen()
    var neighbour = screenNeighbours(screen)[direction]
    if (neighbour !== undefined) {
      putMouseToScreenCenter(neighbour)
      getCurrentWindow().focus()
      screenFocusAlert(neighbour)
    } else {
      Phoenix.log('No neightbour defined in this direction')
      screenFocusAlert(screen)
    }
  }
}

var setupHandlers = function() {
  var modKeys =   ['ctrl', 'alt']
  return {
      up:          new Key('up',    modKeys, changeScreen('north')),
      down:        new Key('down',  modKeys, changeScreen('south')),
      left:        new Key('left',  modKeys, changeScreen('weast')),
      right:       new Key('right', modKeys, changeScreen('east')),
      question:    new Key('space', modKeys, function() { screenFocusAlert() }),
  }
}

var keyHandlres = setupHandlers()

