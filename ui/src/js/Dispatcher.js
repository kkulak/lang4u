import {Dispatcher} from 'flux';
import Constants from './Constants';
import assign from 'object-assign';

export default assign(new Dispatcher(), {

  handleServerAction(action) {
    this.dispatch({
      source: Constants.ActionSources.SERVER_ACTION,
      action: action
    });
  },

  handleViewAction(action) {
    this.dispatch({
      source: Constants.ActionSources.VIEW_ACTION,
      action: action
    });
  }
});
