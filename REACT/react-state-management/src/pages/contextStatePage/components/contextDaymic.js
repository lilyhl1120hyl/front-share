


// 动态使用context
import React, { Component } from 'react'

// 01-定义主题
const themes = {
    light: {
        color: "red",
        background: "#fff"
    },
    dark: {
        color: "green",
        background: "#000"
    }
}
// 02-定义context
const ThemeContext = React.createContext(themes.dark)
// 03-提供provider
class DaymicPage extends Component {
    constructor(props) {
        super(props)
        // theme 被定义成状态维护的主题 动态的值
        this.state = {
            theme:themes.light
        }
    }
    toggleTheme = ()=>{
        // 注意 state 对原有状态 有依赖
         this.setState((preState)=>{
            return {
                theme:preState.theme === themes.light ? themes.dark : themes.light
            }
        })
    }
// provider value 和 thi.state 有关联后
// 通过setState改变value值回触发重新渲染，所有的子组件都会重新渲染(重要)，shouldComponentUpdate有效
    render() {
        return (
            <ThemeContext.Provider value={this.state.theme}>
                <Toolbar changeTheme={this.toggleTheme}/>
            </ThemeContext.Provider>
        )
    }
}
class Toolbar extends Component {
    static contextType = ThemeContext
    render() {
        let { color, background } = this.context
        return (
            <div>
                <div style={{ color: color, background: background }}>ToolBar</div>
                <ThemeButton {...this.props}/>
            </div>
        )
    }
}
class ThemeButton extends Component {
    static contextType = ThemeContext
    render() {
        let {changeTheme} = this.props
        let { color, background } = this.context
        return (
            <button style={{color, background}} onClick={changeTheme}>主题按钮</button>
        )
    }
}

export default DaymicPage