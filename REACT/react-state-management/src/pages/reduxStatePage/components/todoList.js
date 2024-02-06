import React from 'react'
import PropTypes from 'prop-types'
import Todo from './todo'

const propTypes = {
    todos:PropTypes.arrayOf(
        PropTypes.shape({
            id: PropTypes.number.isRequired,
            completed: PropTypes.bool.isRequired,
            text: PropTypes.string.isRequired
        }).isRequired
    ).isRequired,
    onTodoClick: PropTypes.func.isRequired
}

function TodoList(props) {
    const {todos, onTodoClick} = props;
    return (
       <ul>
        {todos.map((todo, index)=>{
            return (
                <Todo key={index} {...todo} onClick={()=>onTodoClick(index)}></Todo>
            )
        })}
       </ul>
    )
}

TodoList.propTypes = propTypes

export default TodoList
