import { legacy_createStore as createStore, applyMiddleware} from 'redux'
import thunkMiddleware from 'redux-thunk'
import createSagaMiddleware from 'redux-saga'
import todoApp from './reducers'
import rootSaga from './sagas/saga'


const sagaMiddleware = createSagaMiddleware()

let store = createStore(
    todoApp,
    applyMiddleware(
        thunkMiddleware,
        sagaMiddleware
      ),
    );

    // then run the saga
sagaMiddleware.run(rootSaga)

export default store;
