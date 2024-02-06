import { INCREMENTS , DECREMENTS} from '../actions/sagaAction';

export const counter = (state = 1, action ) => {
  console.log(action, "reducer ----2---")
  switch(action.type) {
    case INCREMENTS:
      return state + 1;
    case DECREMENTS: {
        return state-1
      }
    default: return state;
  }
}



