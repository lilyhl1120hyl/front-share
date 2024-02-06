// 组合子模块
// 封装统一导出，供业务使用的方法

import React from "react"
import { CounterStore } from "./counterStore"
import { ListStore } from "./listStore"

// 1. 声明一个rootStore
class RootStore {
    constructor() {
        // 对子模块进行实例化操作
        this.counterSotre = new CounterStore()
        this.listStore = new ListStore()
    }
}

// 实例化RootStore注入context
const rootStore = new RootStore()
// 使用React context机制 完成统一方法封装
// Provider value={传递的数据}
// 查找机制：useContext 优先从Provider value中查找 如果找不到
// 就会找createContext方法传递过来的默认参数
const context = React.createContext(rootStore)

// 导出useStore方法，供组件通过调用该方法使用根实例
const useStore = () => React.useContext(context)
export { useStore }