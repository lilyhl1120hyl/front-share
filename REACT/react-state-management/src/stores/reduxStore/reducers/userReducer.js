const initialState = {
    message: '等待',
    age:'20'
  };
  
  export const user = (state = initialState, action) => {
    console.log(action, "reducer ----3---")
    switch(action.type) {
      case "FETCH_REQUEST":
        return {
          ...state,
          message: '请求中'
        }
      case "FETCH_SUCCEEDED":
        return {
            ...state,
            message: '詹姆斯'
        }
      case "FETCH_FAILURE":
        return {
           ...state,
            message: '请求失败'
        }
      default: return state;
    }
  }
  
