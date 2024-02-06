import React, { Component } from 'react'
import {Link} from 'react-router-dom'

export default class Home extends Component {
    render() {
        return (
            <div>
                首页 <br/>
                <Link to="/mobxPage">mobx</Link> <br/>
                <Link to="/fluxPage">flux</Link> <br/>
                <Link to="/reduxPage">redux</Link> <br/>
                <Link to="/contextPage">context</Link> <br/>
            </div>
        )
    }
}
