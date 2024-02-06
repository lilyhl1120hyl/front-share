import { defineStore } from 'pinia'

 
export const useStore = defineStore('userStore', {
  state: () => {
    return {
      counter: 0,
      name: 'Eduardo',
      arr:['a','b','c']

    }
  },
  getters:{
    counterPar(){
        return this.counter + 100;
    }
  },
  actions:{
    changeCounter(val){
        this.counter += val;
    }
  },
  persist: {
    enabled: true,
    strategies: [
      {
        storage: localStorage,
        paths: ['name', 'age']
      }
    ]
  }  
})