// Allow insecure conection
process.env.NODE_TLS_REJECT_UNAUTHORIZED = '0'

const fetch = require('node-fetch')
const WebSocket = require('ws')
const LCUConnector = require('lcu-connector')

// Setup connector
const connector = new LCUConnector()

// On connect
connector.on('connect', (data) => {
    // Make sure client is ready
    connector.iv = setInterval(({ port, password }) => {
        fetch(`https://riot:${password}@127.0.0.1:${port}/lol-champions/v1/owned-champions-minimal`)
            .then(res => {
                // Response OK
                if (res.ok) {
                    clearInterval(connector.iv)
                    connector.iv = null
                    init(data)
                }
            })
    }, 500, data)
})

// On disconnect
connector.on('disconnect', () => {
    if (connector.iv) clearInterval(connector.iv)
    uninit()
})

let ws = null

/* Initialize */
function init({ port, password }) {
    if (!ws) {
        console.log('\nConnecting to League Client...')

        // Construct websocket
        ws = new WebSocket(`wss://riot:${password}@127.0.0.1:${port}/`, 'wamp')

        // Open listener
        ws.on('open', () => {
            // Subscribe event
            ws.send('[5, "OnJsonApiEvent"]')
            console.log('\nConnected!!!')
        })

        // Message listener
        ws.on('message', (msg) => {
            // Check for ChampSelect
            if (typeof msg === 'string'
                && /eventType":"Create","uri":"\/lol-champ-select\/v1\/session"/.test(msg)) {
                // Make POST request
                fetch(`https://riot:${password}@127.0.0.1:${port}` +
                    '/lol-login/v1/session/invoke?destination=lcdsServiceProxy&method=call&args=["","teambuilder-draft","activateBattleBoostV1",""]',
                    { method: 'POST' }
                )
                    .then(res => res.text())
                    .then(res => {
                        // Check response
                        if (/\{"body"/.test(res)) {
                            // Success
                            console.log('\nYour game is BOOSTED! Enjoy :)')
                        } else {
                            console.log('\nFailed to boost, please exit and try again :(')
                        }
                    })
            }
        })
    }
}

/* Uninitialize */
function uninit() {
    console.log('\nDisconnected! Uninitializing...')
    // Unsubscribe event & close websocket
    if (ws) {
        ws.send('[6, "OnJsonApiEvent"]')
        ws.close()
    }
    // Stop the connector
    connector.stop()
    // Exit
    process.exit(0)
}

console.log('\nWaiting for League Client...')

// Start the connector
connector.start()