import React, { Component } from 'react'

export default class ManyPage extends Component {
    state = {
        age:60
    }
    handleChange = ()=>{
        this.setState({
            age: 80
        })
    }
    render(){
        return (
            <div>
                多个context
                <h2>app:{this.state.age}</h2>  
                <Father/>  
                <button onClick={this.handleChange}>Change Age</button>
            </div>
        )
    }
}


const MoneyContext = React.createContext(50)
const HouseContext = React.createContext("house")
class Father extends React.Component {
    state = {
        money: 100,
        house: "apartment"
    }
    render() {
        // 出现多个context传递数据，可以使用Provider进行嵌套
        return (
            <MoneyContext.Provider value={this.state.money}>
                <HouseContext.Provider value={this.state.house} >
                    <Son />
                </HouseContext.Provider>
            </MoneyContext.Provider>
        )
    }
}

function Son() {
    return (
        <MoneyContext.Consumer>
            {
                (money) => {
                    return (
                        <div>
                            <p>Son组件，获取father值为：{money}</p>
                            <br />
                            <GrandSon />
                        </div>
                    )
                }
            }
        </MoneyContext.Consumer>
    )
}
function GrandSon() {
    // Consumer 包裹内容时，只能是一个函数，不能直接是一个组件
    // 多个Context 时候，可以使用嵌套函数
    return (
        <MoneyContext.Consumer>
            {
                (money) => (
                    <HouseContext.Consumer>
                        {
                            (house) => (
                                <div>
                                    <p>GrandSon组件，获取father的钱为：{money}</p>
                                    <p>GrandSon组件，获取father的房子为：{house}</p>
                                </div>
                            )
                        }
                    </HouseContext.Consumer>
                )
            }
        </MoneyContext.Consumer>
    )
}
// class GrandSon extends React.Component {
//     // contextType使用条件：
//     // 01-类组件
//     // 02-只有一个context时，如果有多个context时会后面的覆盖前面的，所以多个时直接使用consumer嵌套
//     static contextType = MoneyContext
//     static contextType = HouseContext
//     render() {
//         console.log(contextType);
//         let {house,money} = this.context // 不行，不能拿两个，只能拿到后面的
//         return (
//             <div>
//                 <p>GrandSon组件，获取father的钱为：{money}</p>
//                 <p>GrandSon组件，获取father的房子为：{house}</p>
//             </div>
//         )                  
//     }
// }



