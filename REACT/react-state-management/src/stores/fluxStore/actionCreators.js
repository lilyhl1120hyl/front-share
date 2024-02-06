import types from './type';
import dispatcher from './dispatcher';

const actionsCreators = {
   increment(){
      //创建动作
      let actions ={
         type:types.INCREMENT
      }
      dispatcher.dispatch(actions)
   }
}

export default actionsCreators;
