
import React, { Component } from 'react';
import { connect } from 'react-redux';
import { get_user,increment,incrementAsync,decrement } from '../../../stores/reduxStore/actions/sagaAction';
import {addTodo} from '../../../stores/reduxStore/actions'

class SagaApp extends Component {
  constructor(props) {
    super(props)
  }

  render() {
    const { message } = this.props.user;
    console.log(this.props, "props=======")
    return (
      <div className="SagaApp">
          <span className='count'>{ this.props.counter }</span>
          <br />
          <button onClick={ this.props.increment }>同步+1</button>
          <button onClick={ this.props.decrement }>同步-1</button>
          <button onClick={ this.props.incrementAsync }>异步</button>
          <button onClick={ this.props.get_user }>网络请求</button>
          <h1>{ message }</h1>
      </div>
    );
  }
}


//映射组件props的数据部分
const mapStateToProps = (state) => {
  return {
    counter: state.counter,
    user: state.user
  };
};

//映射组件props的函数部分
const  mapDispatchToProps = (dispatch) => {
  return {
    increment:()=>{dispatch(increment())},
    incrementAsync:()=>{dispatch(incrementAsync())},
    decrement:()=>{dispatch(decrement())},
    get_user:()=>{dispatch(get_user())},
  }
};


export default connect(mapStateToProps, mapDispatchToProps)(SagaApp);
