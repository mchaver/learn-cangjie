// Main entry point

// Import styles - %%raw is necessary for SCSS imports in Vite
%%raw(`import '../../../src/styles/main.scss'`)

switch ReactDOM.querySelector("#root") {
| Some(root) => ReactDOM.Client.createRoot(root)->ReactDOM.Client.Root.render(<App />)
| None => ()
}
