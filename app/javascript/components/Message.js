import React from "react"
import PropTypes from "prop-types"

const renderPositionCss = (current_user, message_user) => {
  if (current_user.id == message_user.id) {
    return "chat-box__message chat-box__message--by-self"
  } else {
    return "chat-box__message chat-box__message--by-other"
  }
}

class Message extends React.Component {
  componentDidMount() {
    $(".chat-box__messages-histroy").scrollTop($(".chat-box__messages-histroy")[0].scrollHeight)
  }

  render () {
    return (
      <div className={renderPositionCss(this.props.user, this.props.message.user)}>
        <p className="context">{this.props.message.context}</p>
      </div>
    );
  }
}

export default Message
