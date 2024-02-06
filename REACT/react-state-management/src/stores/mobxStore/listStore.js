import { makeAutoObservable } from "mobx"

class ListStore {
    fooList = ['react', 'vue']

    constructor() {
        makeAutoObservable(this)
    }

    addList = (data) => {
        // this.fooList.push('angular')
        this.fooList.push(data)
    }
}

export { ListStore }