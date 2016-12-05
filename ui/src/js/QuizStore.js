import Dispatcher from './Dispatcher';
import Constants from './Constants';
import BaseStore from './BaseStore';
import assign from 'object-assign';

let _currentQuestion = {};
let _chosenLanguage = '';

const QuizStore = assign({}, BaseStore, {
  getCurrentQuestion() {
    return _currentQuestion;
  },

  getChosenLanguage() {
    return _chosenLanguage;
  },

  dispatcherIndex: Dispatcher.register(function handleAction(payload) {
    const action = payload.action;

    switch (action.type) {
      case Constants.ActionTypes.QUESTION_ARRIVED:
        _currentQuestion = action.question;
        QuizStore.emitChange();
        break;

      case Constants.ActionTypes.QUIZ_ENDED:
        _chosenLanguage = action.language;
        QuizStore.emitChange();
        break;
    }
  })
});

export default QuizStore;
