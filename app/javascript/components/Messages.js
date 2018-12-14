import React from "react"
import PropTypes from "prop-types"
import Message from "./Message"
import Api from "../utils/api"
import { ActionCable } from 'react-actioncable-provider'

class Messages extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      messages: [],
      initialized: false
    }

    this.onReceived = this.onReceived.bind(this)
    this.sendMessage = this.sendMessage.bind(this)
  }

  componentDidMount() {
    this.getMessages()
  }

  getMessages() {
    Api.getMessages(this.props.product.id, this.props.chat_room.id).then(response => {
      this.setState((prevState, props) => {
        return { messages: response.data, initialized: true }
      })
    })
  }

  onReceived (data) {
    this.setState({
      messages: [...this.state.messages, data.message]
    })

    this.scrollToBottom()
  }

  sendMessage(event) {
    event.preventDefault()
    const message = this.refs.newMessage.value

    if (message) {
      this.refs.chat_rooms.perform('send_message', {user_id: this.props.user.id, message: message, chat_room_id: 1})
      this.refs.newMessage.value = ''
    }
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
        <p><i class="fa fa-spinner fa-spin"></i>聊天訊息加載中...</p>
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
