
import React ,{ Component} from 'react';
import fluxStore from '../../stores/fluxStore';
import actionsCreators from '../../stores/fluxStore/actionCreators';

class FluxPage extends Component {

   constructor(){
      super()
      this.state={
         count:fluxStore.getState().count
      }
   }

   increment=() =>{
    actionsCreators.increment()
    fluxStore.emit('add'); // 广播
 }

 componentDidMount(){
    fluxStore.on('add',()=>{ // 订阅
       this.setState({
          count:fluxStore.getState().count,
       })
    })
 }

   render(){
      return(
         <div>
            <h3>flux</h3>
            <button onClick= {this.increment} >增加</button>
            <p> {this.state.count} </p>
         </div>
      )
   }
}
export default FluxPage;

