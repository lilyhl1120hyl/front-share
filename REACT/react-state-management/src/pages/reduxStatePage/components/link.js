/* eslint-disable jsx-a11y/anchor-is-valid */
import React from 'react'
import PropTypes from 'prop-types'

const propTypes = {
    active: PropTypes.bool.isRequired,
    children: PropTypes.node.isRequired,
    onClick: PropTypes.func.isRequired
}

function Link(props) {
    const {active, children, onClick} = props;

    if(active){
        return <span>{children}</span>
    }




    return (
        <a 
        href=""
        onClick={e=>{
            e.preventDefault();
            onClick()
        }}
        >
            {children}
        </a>
    )
}

Link.propTypes = propTypes

export default Link
