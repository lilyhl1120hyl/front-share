
import { takeEvery, call, put,all } from 'redux-saga/effects';
// import axios from 'axios';



function* fetchUser() {
  try {
    //axios.get('https://jsonplaceholder.typicode.com/users')
    // const user = yield call(axios.get, "https://jsonplaceholder.typicode.com/users");
    yield put({type: "FETCH_SUCCEEDED"})
  } catch(e) {
    yield put({type: "FETCH_FAILURE"});
  }
}

function* watchFetchUser() {
  yield all([
     takeEvery('FETCH_REQUEST', fetchUser), // 监听发出Action为FETCH_REQUEST，然后出发请求函数fetchUser
  ])
  
}

export const userSagas = [
  watchFetchUser()
]

