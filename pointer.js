const fs = require('fs');
const bytes = fs.readFileSync(__dirname + '/pointer.wasm');

(async () => {
  const obj = await WebAssembly.instantiate(new Uint8Array(bytes));
  const result = obj.instance.exports.get_ptr();
  console.log({result});
})()