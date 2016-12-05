import React from 'react';
import QuizStore from './QuizStore'
import ActionCreator from './ActionCreators';
import App from './App.jsx';

export default React.createClass({
  _onChange() {
    this.setState({
      question: QuizStore.getCurrentQuestion(),
      language: QuizStore.getChosenLanguage()
    });
  },

  getInitialState() {
    return {
      question: QuizStore.getCurrentQuestion(),
      language: QuizStore.getChosenLanguage()
    };
  },

  componentDidMount() {
    QuizStore.addChangeListener(this._onChange);
  },

  componentWillUnmount() {
    QuizStore.removeChangeListener(this._onChange);
  },

  startQuiz() {
    ActionCreator.startQuiz();
  },

  chooseAnswer(answer) {
    ActionCreator.chooseAnswer(answer);
  },

  render() {
    return (
      <App
        currentQuestion={this.state.question}
        chosenLanguage={this.state.language}
        onStartQuiz={this.startQuiz}
        onChooseAnswer={this.chooseAnswer}
      />
    );
  }
});
