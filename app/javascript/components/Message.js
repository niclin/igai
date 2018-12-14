import React from "react"
import PropTypes from "prop-types"

class Message extends React.Component {
  render () {
    return (
      <div className="row">
        <div className="col-lg-12">
          <div className="chat-list__message">
            <li>{this.props.message.user.email}</li>
            <p>{this.props.message.context}</p>
          </div>
        </div>
      </div>
    );
  }
}

export default Message
