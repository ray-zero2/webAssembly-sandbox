const fs = require('fs');
const export_bytes = fs.readFileSync(__dirname + '/table_export.wasm');
const test_bytes = fs.readFileSync(__dirname + '/table_test.wasm');

let i = 0;
const increment = () => {
  i ++;
  return i;
}
const decrement = () => {
  i --;
  return i;
}

const importObject = {
  js: {
    tbl: null,
    increment,
    decrement,
    wasm_increment: null,
    wasm_decrement: null
  }
};

const testPerformance = (name, callback) => {
  i = 0;
  const start = performance.now()
  callback();
  const time = performance.now() - start;
  console.log(`${name} time: ${time}ms`);
}

(async () => {
  const table_exp_obj = await WebAssembly.instantiate(new Uint8Array(export_bytes), importObject);
  const { tbl, increment: wasm_increment, decrement: wasm_decrement} = table_exp_obj.instance.exports;
  importObject.js.tbl = tbl;
  importObject.js.wasm_increment = wasm_increment;
  importObject.js.wasm_decrement = wasm_decrement;

  const obj = await WebAssembly.instantiate(new Uint8Array(test_bytes), importObject);
  const {
    js_table_test,
    js_import_test,
    wasm_table_test,
    wasm_import_test
   } = obj.instance.exports;

   testPerformance('js_table_test', js_table_test);
   testPerformance('js_import_test', js_import_test);
   testPerformance('wasm_table_test', wasm_table_test);
   testPerformance('wasm_import_test', wasm_import_test);
})()