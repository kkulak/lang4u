import socketio from 'socket.io-client'
import ActionCreators from './ActionCreators'
import Dispatcher from './Dispatcher'
import Constants from './Constants'

export default  {
  connect: host => {
    let socket = socketio(host);

    socket.on('question', function (payload) {
      ActionCreators.updateQuestion(payload.data);
    });

    socket.on('answer', function (payload) {
      ActionCreators.endQuiz(payload.data.value);
    });

    Dispatcher.register(function handleAction(payload) {
      const action = payload.action;

      switch (action.type) {
        case Constants.ActionTypes.QUIZ_STARTED:
          socket.emit('start_quiz', {});
          break;

        case Constants.ActionTypes.ANSWER_CHOSEN:
          socket.emit('answer', {data: action.answer});
          break;
      }
    });
  }
};

