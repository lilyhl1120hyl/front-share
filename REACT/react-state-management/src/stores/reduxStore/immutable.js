// // 在redux中使用immutable.js
// // redux官网推荐使用redux-immutable进行redux和immutable的集成。几个注意点：
// // redux中，利用combineReducers来合并多个reduce, redux自带的combineReducers只支持原生js形式的，
// // 所以需要使用redux-immutable提供的combineReducers来代替

// // 使用redux-immutable提供的combineReducers方法替换redux里的combineReducers
// import {combineReducers} from 'redux-immutable'
// import reducerOne from './reducerOne'
// import reducerTwo from './reducerTwo'
 
// const rootReducer = combineReducers({
//     reducerOne,
//     reducerTwo
// });
 
// export default rootReducer;

// // reducer中的initialState也需要初始化成immutable类型, 比如一个counter的reducer

// import { Map } from 'immutable'

// import ActionTypes from '../actions'

// const initialState = Map({
//   count: 0
// })

// export default (state = initialState, action) => {
//   switch (action.type) {
//     case ActionTypes.INCREAMENT:
//       return state.set('count', state.get('count') + 1) // 使用set或setIn来更改值, get或者getIn来取值
//     case ActionTypes.DECREAMENT:
//       return state.set('count', state.get('count') - 1)
//     default:
//       return state
//   }
// }


// // state成为了immutable类型，connect的mapStateToProp也需要相应的改变

// const mapStateToProps = state => ({
//   count: state.getIn(['counter', 'count']) // 永远不要在mapStateToProps里使用`toJS`方法，因为它永远返回一个新的对象
// })


// // 在shouldComponentUpdate里就可以使用immutable.is或者instance.equals来进行数据的对比了。
