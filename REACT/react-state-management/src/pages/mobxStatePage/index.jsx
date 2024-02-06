

import Bar from './components/bar'
import Foo from './components/foo'
import { useStore } from "../../stores/mobxStore"

function MobxPage() {
  const { listStore } = useStore()
  return (
    <div >
         mobx 案例
      <Bar />
      <br/>
      <button onClick={() => listStore.addList('angular1')}>
        修改taskStore
      </button>
      <br/>
      <Foo/>
    </div>
  )
}
export default MobxPage