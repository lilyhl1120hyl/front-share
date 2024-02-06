import { all } from 'redux-saga/effects'

import {userSagas} from "./userSaga"
import {counterSagas} from "./counterSaga"

// single entry point to start all Sagas at once
export default function* rootSaga() {
   
    yield all([
        ...counterSagas,
        ...userSagas
      ])
  }