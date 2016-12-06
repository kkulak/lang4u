import React, {PropTypes} from 'react';
import ListGroup from '../../node_modules/react-bootstrap/lib/ListGroup'
import Answer from './Answer.jsx'
import uuid from 'node-uuid';

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
                <Answer key={this.answerIdentifier(answer)}
                        text={answer.text}
                        onSelect={chooseAnswer(answer.ordinal)}
                        bsStyle="success" active>
                </Answer>
              )
            })
          }
        </ListGroup>
      </div>
    );
  },

  answerIdentifier(answer) {
    return answer.ordinal + uuid.v4()
  }
});
