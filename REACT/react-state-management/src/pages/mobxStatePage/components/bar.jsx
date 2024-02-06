import { useStore } from "../../../stores/mobxStore";
import { observer } from "mobx-react-lite";

const Bar = () => {
  const { counterSotre } = useStore();
  let input;
  return (
    <div>
      <button onClick={() => counterSotre.addCount()}>count add</button> <br />
      <div>{counterSotre.count} </div>
      <form
        onSubmit={(e) => {
          e.preventDefault();
          if (!input.value.trim()) {
            return;
          }
          counterSotre.addList(input.value);
          input.value = "";
        }}
      >
        <input
          ref={(node) => {
            input = node;
          }}
        ></input>
        <button type="submit">list add</button>
      </form>
      <br />
      <ul>
        {counterSotre.countList.map((item) => (
          <li key={item}>{item}</li>
        ))}
      </ul>

     <div>计算属性</div>
      <ul>
        {counterSotre.filterList.map((item) => (
          <li key={item}>{item}</li>
        ))}
      </ul>
    </div>
  );
};

export default observer(Bar);
