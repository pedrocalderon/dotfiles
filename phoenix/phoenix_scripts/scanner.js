// credit to mafredi/phoenix-config scanner

var normalKeys = `§1234567890+qwertyuiopåasdfghjklöä'<zxcvbnm,.-`.split('')
var shiftKeys = `°!"#€%&/()=?QWERTYUIOPÅASDFGHJKLÖÄ*>ZXCVBNM;:_`.split('')
var altKeys = ` ©@£$∞§|[]≈±•Ωé®†µüıœπ˙ß∂ƒ¸˛√ªﬁøæ™  ≈ç‹›‘’‚ –`.split('')
var altShiftKeys = `•      \\{}`.split('')
var specialKeys = ['delete', 'escape', 'return', 'space']

// we need to use a constructor for encapsulation
// normaly I would use a module, but we cannot
// do that with Phoenix (apparently)
function Scanner() {
  this.keyHandlers = []
  this.modal = null
  this.doneCallback = Function.prototype
  this.updateCallback = Function.prototype
  this.scanned = ''
  return this
}

Scanner.prototype.disable = function() {
  this.keyHandlers.forEach(function(handler) {
    handler.disable()
  })
  this.keyHandlers = [] // drop the references
}

Scanner.prototype.handleKeyPress = function(key, handler) {
  switch (key) {
    case 'delete':
      this.scanned = this.scanned.slice(0, -1)
      return this.updateCallback(this.scanned)
    case 'escape':
      this.disable()
      this.doneCallback(undefined)
      this.closeModal()
    case 'return':
      if (handler && handler.modifiers.indexOf('shift') !== -1) {
        this.scanned += '\n'
        return this.updateCallback(this.scanned)
      }
      this.disable()
      return this.updateCallback(this.scanned)
    case 'space':
        this.scanned += ' '
        return this.updateCallback(this.scanned)
    default:
        this.scanned += key
        return this.updateCallback(this.scanned)
  }
}

Scanner.prototype.enable = function(done) {
  var that = this
  this.scanned = '' // reset input
  this.keyHandlers.length = 0 // remove stale keyhandlers
  var normalKeysHandlers = normalKeys.map(function(key, idx) {
    var ask = altShiftKeys[idx] || ' '
    return [
      new Key(key, [], function() { that.handleKeyPress(key) }),
      new Key(key, ['shift'], function() { that.handleKeyPress(shiftKeys[idx]) }),
      new Key(key, ['alt'], function() { that.handleKeyPress(altKeys[idx]) }),
      new Key(key, ['alt', 'shift'], function() { that.handleKeyPress(ask) }),
    ]
  })
  var specialKeysHandlers = specialKeys.map(function(key) {
    return [
      new Key(key, [], function() { that.handleKeyPress(key) }),
      new Key(key, ['shift'], function(handler) { that.handleKeyPress(key, handler) }),
    ]
  })
  this.keyHandlers = _.flatten([normalKeysHandlers, specialKeysHandlers])
}

Scanner.prototype.scan = function(done) {
  if (!done) done = Function.prototype

  this.enable()
  this.doneCallback = function() {
    this.closeModal()
    done.apply(this, arguments)
  }
  this.updateCallback = function(key) {
    if (!key) return
    this.disable()
    this.updateModal(key)
    this.closeModal()
    done(key)
  }
  this.openModal()
}

Scanner.prototype.scanln = function(done, update) {
  if (!done) done = Function.prototype
  if (!update) update = Function.prototype

  this.enable()
  this.doneCallback = function() {
    this.closeModal()
    done.apply(this, arguments)
  }
  this.updateCallback = function(scann) {
    this.updateModal(scann)
    update(scann)
  }
  this.openModal()
}

// TODO: change modal origin to keep it centered
Scanner.prototype.openModal = function() {
  var mouse = Mouse.location()
  var screen = Screen.all().filter(function(s) {
    return mouseIsInScreen(s)
  })[0]

  var alertModal      = new Modal()
  alertModal.baseMsg = 'Scanner:\n'
  alertModal.message  = 'Scanner:\n'

  var screenFrame     = screen.frameInRectangle()
  var alertFrame      = alertModal.frame()

  alertModal.origin = {
    x: screenFrame.x + screenFrame.width/2,
    y: screenFrame.y + screenFrame.height/2,
  }
  alertModal.show()

  this.modal = alertModal
}

Scanner.prototype.updateModal = function(msg) {
  this.modal.message = this.modal.baseMsg + msg
}

Scanner.prototype.closeModal = function() {
  if (this.modal) {
    this.modal.close()
    this.modal = null // drop the reference
  }
}

