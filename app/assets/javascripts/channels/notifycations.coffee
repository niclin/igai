App.notifycations = App.cable.subscriptions.create {
  channel: "NotifycationsChannel",
  user_id: gon.user_id
},
  connected: ->
    # Called when the subscription is ready for use on the server
    toastr.success('Notifycation websocket connected.')

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    toastr.info('You have new message!')

