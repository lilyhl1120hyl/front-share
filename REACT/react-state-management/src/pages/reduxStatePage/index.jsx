import React, { Component } from 'react'
import Footer from './components/footer'
import AddTodo from './containers/addTodo'
import VisibleTodoList from './containers/visibleTodoList'
import ThunkApp from './containers/thunkApp'
import SagaApp from './containers/sagaApp'

export default class Home extends Component {
    render() {
        return (
            <div>
              <h2> redux 使用案例 </h2>  
              <AddTodo/>
              <VisibleTodoList/>
              <Footer/>
              <h2> redux, redux-thunk 使用案例 </h2>  
              <ThunkApp/>
              <h2> redux, redux-saga 使用案例 </h2>  
              <SagaApp/>
            </div>
        )
    }
}
