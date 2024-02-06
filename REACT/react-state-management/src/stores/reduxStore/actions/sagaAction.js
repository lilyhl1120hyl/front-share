export const INCREMENTS = 'INCREMENTS';
export const INCREMENT_ASYNC = 'INCREMENT_ASYNC';
export const DECREMENTS = 'DECREMENTS'
export const FETCH_REQUEST ='FETCH_REQUEST'


//count+1
export const increment = () => {
  console.log("action--1")
  return {
    type: INCREMENTS
  }
};


//count-1
export const decrement = () => {
  console.log("decrement--1")
  return {
    type:DECREMENTS
  }
}

//异步增加
export const incrementAsync = () => {
  console.log("incrementAsync--1")
  return {
    type: INCREMENT_ASYNC
  }
};


export const get_user = () => {
  console.log("get_user--1")
    return {
      type: FETCH_REQUEST
    }
};