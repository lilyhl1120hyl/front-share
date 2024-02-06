import React, { Component } from 'react'

import ManyPage from './components/contextMany'
import BasePage from './components/contextBase'
import DaymicPage from './components/contextDaymic'

import {Container} from './styles/style'


export default class ContextPage extends Component {
    render() {
        return (
            <Container>
                context 案例
                <BasePage/>
                <br/>
                <DaymicPage/>
                <br/>
                <ManyPage/>
            </Container>
        )
    }
}
