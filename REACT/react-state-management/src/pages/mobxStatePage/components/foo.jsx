// 用taskStore中的taskList数据
import { useStore } from "../../../stores/mobxStore"
import { observer } from 'mobx-react-lite'


const Foo = () => {
  const { listStore } = useStore()
  return (
    <ul>
      {listStore.fooList.map((item) => (
        <li key={item}>{item}</li>
      ))}
    </ul>
  )
}

export default observer(Foo)