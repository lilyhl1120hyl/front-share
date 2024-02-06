    // store/index.js

    const EventEmitter = require( 'events' ).EventEmitter

    const fluxStore = {
      ...EventEmitter.prototype,
      state: {
        count: 0
      },
      getState () {
        return this.state
      },
      handleAdd(){
        this.state.count ++;
    },
    }
    export default fluxStore 
