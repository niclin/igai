App.chat_rooms = App.cable.subscriptions.create {
    channel: "ChatRoomsChannel"
    chat_room_id: messages.data('chat-room-id')
  },
  connected: ->
    # Called when the subscription is ready for use on the server
    toastr.success('Char room websocket connected.')

  disconnected: ->
    # Called when the subscription has been terminated by the server
    toastr.error('Chat room websocket disconnect.')

  received: (data) ->

