import React from "react"
import PropTypes from "prop-types"
import moment from "moment"

const renderPositionCss = (current_user, message_user) => {
  if (current_user.id == message_user.id) {
    return "chat-box__message chat-box__message--by-self"
  } else {
    return "chat-box__message chat-box__message--by-other"
  }
}

const renderMessageStatus = (current_user, message) => {
  if (current_user.id == message.user.id) {
    if (message.read) {
      return <i className="fa fa-check" />
    } else {
      return <i className="fa fa-circle-thin" />
    }
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
        <div className="chat-box__timestamp">
          {renderMessageStatus(this.props.user, this.props.message)}
          <small>{moment(this.props.message.created_at).format("MM/D kk:mm:ss")}</small>
        </div>
      </div>
    );
  }
}

export default Message
