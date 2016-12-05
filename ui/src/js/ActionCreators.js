import Dispatcher from './Dispatcher';
import Constants from './Constants';

export default {
  startQuiz() {
    Dispatcher.handleViewAction({
      type: Constants.ActionTypes.QUIZ_STARTED
    });
  },

  chooseAnswer(answer) {
    Dispatcher.handleViewAction({
      type: Constants.ActionTypes.ANSWER_CHOSEN,
      answer: answer
    });
  },

  updateQuestion(question) {
    Dispatcher.handleServerAction({
      type: Constants.ActionTypes.QUESTION_ARRIVED,
      question: question
    });
  },

  endQuiz(chosenLanguage) {
    Dispatcher.handleServerAction({
      type: Constants.ActionTypes.QUIZ_ENDED,
      language: chosenLanguage
    });
  }
};
