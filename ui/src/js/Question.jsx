import React, {PropTypes} from 'react';
import ListGroup from '../../node_modules/react-bootstrap/lib/ListGroup'
import ListGroupItem from '../../node_modules/react-bootstrap/lib/ListGroupItem'

export default React.createClass({
  propTypes: {
    question: PropTypes.object.isRequired,
    onChooseAnswer: PropTypes.func.isRequired
  },

  render() {
    let {question, onChooseAnswer} = this.props;
    let chooseAnswer = answer => () => onChooseAnswer(answer);

    return (
      <div className="container">
        <p>{question.text}</p>

        <ListGroup>
          {
            question.answers.map(answer => {
              return (
                <ListGroupItem key={answer.ordinal} onClick={chooseAnswer(answer.ordinal)}>
                  {answer.text}
                </ListGroupItem>
              )
            })
          }
        </ListGroup>
      </div>
    );
  }
});
