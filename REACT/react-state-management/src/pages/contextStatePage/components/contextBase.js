import React, { Component } from 'react'

const ThemeContext = React.createContext('red')

export default class BasePage extends Component {
    render() {
        return (
            // 01-Provider 将theme主题 通过value属性传递给 所有子元素 子组件的props.children        
            // Provider是一个组件，允许消费组件 订阅context变化
            // Provider value属性值发生变化，内部所有的消费组件都会重新渲染
            // 若组件树中，没有匹配到provider，则 使用默认值 defaultValue
            <ThemeContext.Provider value="green">
                <div className='baseTitle'>context 基本使用</div>
                <Toolbar_1 />
            </ThemeContext.Provider>
        )
    }
}
class Toolbar_1 extends Component {
    render(){
        return (
        // 03-通过Consumer 订阅context的变更
        // 使用 函数作为子元素，函数参数 就是当前的context的值（provider value属性值）
        // 函数返回值就是react的一个结点元素
            <ThemeContext.Consumer>
                {
                    (value) => {
                        return (
                            <div>
                                <div style={{ color: value }}>Toolbar</div>
                                <ThemeButton theme={value} />
                            </div>
                        )
                    }
                }
            </ThemeContext.Consumer>
        )
    }
}
// 02-使用contextType
// 只能在类组件内使用，函数组件内使用 不好使
// 但是<Consumer>在函数组件和类组件内都可以使用
class Toolbar_2 extends Component {
    // 也可以使用默认属性赋值
    static contextType = ThemeContext
    render() {
        return (
            <div>
                <div style={{ color: this.context }}>Toolbar</div>
                <ThemeButton theme={this.context} />
            </div>
        )
    }
}

class ThemeButton extends Component {
    render() {
        return (
            <ThemeContext.Consumer>
                {
                    (value) => (
                            <button style={{ color: value }}>主题按钮</button>
                        )
                }
            </ThemeContext.Consumer>
        )
    }
}



