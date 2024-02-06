import { combineReducers } from "redux";
import { todos } from './todos'
import { visibilityFilter } from "./visibilityFilter";
import { postsBySubreddit, selectedSubreddit } from "./fetchReducer";
import {user} from './userReducer';
import {counter} from "./counterReducer";


const todoApp = combineReducers({
    todos,
    visibilityFilter,
    postsBySubreddit,
    selectedSubreddit,
    user,
    counter
})

export default todoApp


