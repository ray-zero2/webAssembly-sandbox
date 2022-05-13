const fs = require('fs');
const bytes = fs.readFileSync(__dirname + '/func_perform.wasm');

let i = 0;
const importObject = {
  js: {
    "external_call": () => {
      i ++;
      return i;
    }
  }
};

(async () => {
  const obj = await WebAssembly.instantiate(new Uint8Array(bytes), importObject);

  const { wasm_call, js_call } = obj.instance.exports;

  // native wasm func
  let start = performance.now();
  wasm_call();
  let time = performance.now() - start;
  console.log(`wasm call time: ${time}ms`);

  // JavaScript func
  start = performance.now();
  js_call();
  time = performance.now() - start;
  console.log(`js call time: ${time}ms`);

})()