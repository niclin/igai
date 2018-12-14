import React from "react"
import PropTypes from "prop-types"
import Messages from "./Messages"
import { ActionCableProvider } from 'react-actioncable-provider'

const cable = ActionCable.createConsumer(process.env.NODE_ENV === 'production' ? 'wss://igai.info:3334/cable' : 'ws://localhost:3334/cable')

class Chat extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      user: this.props.current_user,
      product: this.props.product,
      chat_room: this.props.chat_room
    }
  }

  render () {
    return (
      <ActionCableProvider cable={cable}>
        <Messages {...this.state} />
      </ActionCableProvider>
    )
  }
}

export default Chat
