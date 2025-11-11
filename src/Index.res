// Main entry point

%%raw(`import '../../../src/styles/main.scss'`)

switch ReactDOM.querySelector("#root") {
| Some(root) => ReactDOM.Client.createRoot(root)->ReactDOM.Client.Root.render(<App />)
| None => ()
}
