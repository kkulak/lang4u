import React, {PropTypes} from 'react';
import Button from '../../node_modules/react-bootstrap/lib/Button';
import Jumbotron from '../../node_modules/react-bootstrap/lib/Jumbotron';
import Question from './Question.jsx'

export default React.createClass({
  propTypes: {
    onStartQuiz: PropTypes.func.isRequired,
    onChooseAnswer: PropTypes.func.isRequired
  },

  render() {
    let {currentQuestion, chosenLanguage, onStartQuiz, onChooseAnswer} = this.props;

    return (
      <div className="container">
        <Jumbotron>
          <h1>Lang4U</h1>
          <p>
            Lang4U will help you choose your first programming language.<br/>
            Just answer a couple of questions and start your programming journey!
          </p>
        </Jumbotron>

        <div>
          {!this.quizAlreadyStarted() && <Button onClick={onStartQuiz} bsStyle="primary">Start Quiz!</Button>}
          {this.quizAlreadyStarted() && <Question question={currentQuestion} onChooseAnswer={onChooseAnswer}/>}
          {this.quizEnded() && <p>{chosenLanguage}</p>}
        </div>
      </div>
    );
  },

  quizAlreadyStarted() {
    return Object.keys(this.props.currentQuestion).length !== 0
  },

  quizEnded() {
    return !!this.props.chosenLanguage;
  }
});
