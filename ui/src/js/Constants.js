import keyMirror from 'react/lib/keyMirror';

export default {
  CHANGE_EVENT: 'change',

  ActionTypes: keyMirror({
    QUIZ_STARTED: null,
    ANSWER_CHOSEN: null,
    QUESTION_ARRIVED: null,
    QUIZ_ENDED: null
  }),

  ActionSources: keyMirror({
    SERVER_ACTION: null,
    VIEW_ACTION: null
  })
};
