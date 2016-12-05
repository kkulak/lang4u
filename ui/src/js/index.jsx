import React from 'react';
import AppContainer from './AppContainer.jsx';
import WebSocket from './WebSocketHook'

WebSocket.connect('localhost:5000/lang4u');
React.render(<AppContainer />, document.getElementById('main'));
