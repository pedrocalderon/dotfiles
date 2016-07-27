var timeDisplayHandler = new Key('t', ['ctrl', 'alt'], function() {
  var date = new Date().toTimeString().substring(0, 5)
  var timeModal = new Modal()
  timeModal.duration = 2
  timeModal.message = date
  timeModal.show()
})
