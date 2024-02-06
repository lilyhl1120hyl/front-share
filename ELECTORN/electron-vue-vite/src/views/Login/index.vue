<script setup lang="ts">
import { ref } from "vue";
import { storeToRefs } from "pinia";
import { useStore } from "../../store/user";

defineProps<{ msg: string }>();

// 使用 store数据
const store = useStore();
let { name, counter, arr, counterPar } = storeToRefs(store);

const btn = () => {
  //批量更新
  store.$patch((state) => {
    state.counter++;
    state.arr.push(4);
    state.name = "456";
  });
};

const add = () => {
  store.changeCounter(10);
};

const count = ref(0);
</script>

<template>
  <div>
    登录页面
    <h1>{{ msg }}</h1>

    <div class="card">
      <button type="button" @click="count++">count is {{ count }}</button>
    </div>

    {{ name }}
    {{ counter }}
    {{ arr }}
    <button @click="btn">按钮</button>

    {{ counter }}
    <button @click="add">加10</button>

    <div>getter: {{ counterPar }}</div>
  </div>
</template>

<style scoped lang="less"></style>
