
import { 
    takeEvery, delay, put,take,fork,takeLatest,select,all
  } from 'redux-saga/effects';
  import { INCREMENT_ASYNC , INCREMENT_TAKE,DECREMENT} from '../actions/sagaAction';
  
  
  function* incrementAsync(action) {
  
    let state = yield select(state => console.log(state,'state---'))

    yield delay(2000);
    yield put({ type: 'INCREMENTS' })
   
  }
  
  export function* watchIncrementAsync() {
    //  while(true){
    //    yield take('INCREMENT_ASYNC');
    //    yield fork(incrementAsync);
    //    yield fork(()=>{console.log('----INCREMENT_ASYNC----')})
    // }
   

    yield takeEvery('INCREMENT_ASYNC', incrementAsync)
  }
  
  export const counterSagas = [
    watchIncrementAsync(),
  ]
  