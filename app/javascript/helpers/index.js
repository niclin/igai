const browserIfNotFocus = () => {
  if (!parent.document.hasFocus()) {
    toastr.info("您有新訊息")
  }
}

const playSound = () => {
  var sound = document.getElementById("msgSound")
  if (sound) {
    sound.play()
  }
}

export { browserIfNotFocus, playSound }
