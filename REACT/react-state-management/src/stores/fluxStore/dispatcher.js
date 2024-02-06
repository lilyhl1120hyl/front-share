import { Dispatcher } from 'flux'
import types from './type'
import fluxStore from './index'
const dispatcher = new Dispatcher()

// 注册dispatcher 
dispatcher.register(( action ) => {
  switch ( action.type ) {
    case types.INCREMENT:
      // 修改数据
      fluxStore.handleAdd();
      break;
    default:
      break;
  }
})


export default dispatcher
