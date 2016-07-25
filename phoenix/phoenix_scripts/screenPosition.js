var setTopLeftHandler = new Key('q', [ 'ctrl', 'shift' ], function () {
  Window.focused().setTopLeft({ x: 0, y: 0 })
})

var toLeftHandler = new Key('left', ['ctrl', 'cmd'], function() {
  Phoenix.notify('oi')
})

