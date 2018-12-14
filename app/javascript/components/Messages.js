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

  sendMessage = () => {
    const message = this.refs.newMessage.value

    if (message) {
      this.refs.chat_rooms.perform('send_message', {user_id: this.props.current_user.id, message: message, chat_room_id: 1})
      this.refs.newMessage.value = ''
    }
  }

  scrollToBottom() {
    const scrollBottom = $(window).scrollTop() + $(window).height()
    window.scrollTo(0, scrollBottom)
  }

  render () {
    let messages

    if (this.state.initialized) {
      messages = this.state.messages.map(message => {
        return (
          <Message
            key={`chat.message.${message.id}`}
            message={message}
            user={this.props.current_user}
          />
        )
      })

    } else {
      messages = (
        <p>Initializing chat room</p>
      )
    }
    return (
      <div className="row">
      <ActionCable ref='chat_rooms' channel={{channel: 'ChatRoomsChannel', chat_room_id: this.props.chat_room.id}} onReceived={this.onReceived} />
        <div className="col-lg-12" id="messages">
          {messages}
        </div>
        <input ref='newMessage' type='text' />
        <button onClick={this.sendMessage}>Send</button>
      </div>
    )
  }
}

Messages.defaultProps = {
  messages: []
}

export default Messages
