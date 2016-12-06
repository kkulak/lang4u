import React, {PropTypes} from 'react';
import ListGroupItem from '../../node_modules/react-bootstrap/lib/ListGroupItem'

export default React.createClass({
  propTypes: {
    text: PropTypes.string.isRequired,
    onSelect: PropTypes.func.isRequired
  },

  getInitialState() {
    return {selected: false};
  },

  select() {
    this.setState({selected: true});
    this.props.onSelect();
  },

  render() {
    const styles = {
      width: '50%',
      margin: '5px'
    };

    return (
      <ListGroupItem onClick={this.select}
                     bsStyle="info"
                     className={this.state.selected ? "active": ""}
                     style={styles}>
        {this.props.text}
      </ListGroupItem>
    );
  }
});
