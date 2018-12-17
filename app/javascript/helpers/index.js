const browserIfNotFocus = () => {

  if (!parent.document.hasFocus()) {
    toastr.info("您有新訊息")
  }
}

export { browserIfNotFocus }
