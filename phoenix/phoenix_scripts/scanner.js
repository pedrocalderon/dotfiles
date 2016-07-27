// credit to mafredi/phoenix-config scanner

var alphakeys = 'qwertyuiopasdfghjklzxcvbnm'.split('')

// we need to use a constructor for encapsulation
// normaly I would use a module, but we cannot
// do that with Phoenix (apparently)
function Scanner() {
  this.keyHandlers = []
  this.modal = null
  return this
}

Scanner.prototype.disable = function() {
  this.keyHandlers.forEach(function(handler) {
    handler.disable()
  })
  this.keyHandlers = [] // drop the references
}

Scanner.prototype.handleKeyPress = function(key, done) {
  this.disable()
  this.closeModal()
  done(key)
}

Scanner.prototype.enable = function(done) {
  var that = this
  this.scanned = '' // reset input
  this.keyHandlers.length = 0 // remove stale keyhandlers
  this.keyHandlers = alphakeys.map(function(key) {
    return new Key(key, [], function() {
      that.handleKeyPress(key, done)
    })
  })
}

Scanner.prototype.scan = function(done) {
  this.enable(done)
  this.openModal()
}

Scanner.prototype.openModal = function() {
  var mouse = Mouse.location()
  var screen = Screen.all().filter(function(s) {
    return mouseIsInScreen(s)
  })[0]

  var alertModal      = new Modal()
  alertModal.message  = 'Waiting for alpha char'

  var screenFrame     = screen.frameInRectangle()
  var alertFrame      = alertModal.frame()

  alertModal.origin = {
    x: screenFrame.x + screenFrame.width/2,
    y: screenFrame.y + screenFrame.height/2,
  }
  alertModal.show()

  this.modal = alertModal
}

Scanner.prototype.closeModal = function() {
  if (this.modal) {
    this.modal.close()
    this.modal = null // drop the reference
  }
}

