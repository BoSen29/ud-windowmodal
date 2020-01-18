import React, {Component} from 'react';
import WindowModal from "react-window-modal";

const startPos = { x: 25, y: 25 };
const startSize = { x: 600, y: 600};

export default class UDHotkeys extends Component {

  render() {
    if (this.props.hidden) {
      return (null);
    }
    else {
      console.log(this.props.content);
      var content = this.props.content;
        if (!Array.isArray(content))
        {
            content = [content]
        }
      content = content.map(x => {
        return UniversalDashboard.renderComponent(x);
      });
      console.log(content);
      return (
        <WindowModal title={this.props.title} pos={startPos} size={startSize} id={this.props.id}>
          <span>
            {content}
          </span>
        </WindowModal>
      );
    }
  }
}