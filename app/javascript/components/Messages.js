import React from "react"
import PropTypes from "prop-types"
import Message from "./Message"
import Api from "../utils/api"
import { ActionCable } from 'react-actioncable-provider'
import * as helpers from "../helpers/index"

class Messages extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      messages: [],
      initialized: false
    }

    this.receivedNewMessage = this.receivedNewMessage.bind(this)
    this.sendMessage = this.sendMessage.bind(this)
    this.updateMessagesStatus = this.updateMessagesStatus.bind(this)
    this.onReceived = this.onReceived.bind(this)
  }

  componentDidMount() {
    this.getMessages()
    this.detectUserActivity()
  }

  getMessages() {
    Api.getMessages(this.props.chat_room.id).then(response => {
      this.setState((prevState, props) => {
        return { messages: response.data, initialized: true }
      })
    })
  }

  onReceived (data) {
    switch (data.event) {
      case "new_message":
        return this.receivedNewMessage(data)
        break
      case "mark_as_read":
        return this.updateMessagesStatus(data)
        break
    }
  }

  updateMessagesStatus (data) {
    this.getMessages()
  }

  receivedNewMessage (data) {
    this.setState({
      messages: [...this.state.messages, data.message]
    })

    this.scrollToBottom()

    // send from the other user
    if (this.props.user.id != data.message.user.id) {
      helpers.playSound()
      helpers.browserIfNotFocus()
    }
  }

  sendMessage(event) {
    event.preventDefault()
    const message = this.refs.newMessage.value

    if (message) {
      this.refs.chat_rooms.perform('send_message', {user_id: this.props.user.id, message: message, chat_room_id: this.props.chat_room.id})
      this.refs.newMessage.value = ''
    }
  }

  detectUserActivity() {
    $("body").click(() => {
      if (!this.state.initialized) {
        return
      }

      const unreadMessages = this.state.messages.filter(
        message => !message.read && message.user.id != this.props.user.id
      )

      if (unreadMessages.length > 0) {
        Api.markAllMessagesAsRead(this.props.chat_room.id, this.props.user.id)
      }
    })

  }

  scrollToBottom() {
    $(".chat-box__messages-histroy").scrollTop($(".chat-box__messages-histroy")[0].scrollHeight)
  }

  render () {
    let messages

    if (this.state.initialized) {
      messages = this.state.messages.map(message => {
        return (
          <Message
            key={`chat.message.${message.id}`}
            message={message}
            user={this.props.user}
          />
        )
      })

    } else {
      messages = (
        <p><i className="fa fa-spinner fa-spin"></i>聊天訊息加載中...</p>
      )
    }
    return (
      <div className="chat-box">
      <ActionCable ref='chat_rooms' channel={{channel: 'ChatRoomsChannel', chat_room_id: this.props.chat_room.id}} onReceived={this.onReceived} />
        <div className="chat-box__messages-content">
          <div className="chat-box__messages-histroy">
            {messages}
          </div>

          <form onSubmit={this.sendMessage} noValidate="novalidate">
            <div className="chat-box__input-wrapper">
              <input className="chat-box__input" ref='newMessage' type='text' placeholder="輸入訊息﹍" autoFocus={true} />
              <button type="submit" className="chat-box__submit-btn"><i className="fa fa-paper-plane-o" aria-hidden="true"></i></button>
            </div>
          </form>
        </div>
      </div>
    )
  }
}

Messages.defaultProps = {
  messages: []
}

export default Messages
