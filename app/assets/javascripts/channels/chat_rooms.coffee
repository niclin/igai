jQuery(document).on 'turbolinks:load', ->
  messages = $('#messages')
  if $('#messages').length > 0
    messages_to_bottom = -> messages.scrollTop(messages.prop("scrollHeight"))

    messages_to_bottom()

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
        messages.append data['message']
        messages_to_bottom()

      send_message: (message, chat_room_id) ->
        @perform 'send_message', message: message, chat_room_id: chat_room_id

    $('#new_message').submit (e) ->
      $this = $(this)
      textarea = $this.find('#message_context')
      if $.trim(textarea.val()).length > 1
        App.chat_rooms.send_message textarea.val(), messages.data('chat-room-id')
        textarea.val('')
      e.preventDefault()
      return false
