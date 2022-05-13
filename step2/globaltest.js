const fs = require('fs');
const bytes = fs.readFileSync(__dirname + '/global.wasm');

const importObject = {
  js: {
    log_i32: (value) => {console.log(`i32: ${value}`)},
    log_f32: (value) => {console.log(`f32: ${value}`)},
    log_f64: (value) => {console.log(`f64: ${value}`)},
  },
  env: {
    import_i32: 5_000_000_000,
    import_f32: 123.0123456789,
    import_f64: 123.0123456789,
  }
};

(async() => {
  const obj = await WebAssembly.instantiate(new Uint8Array(bytes), importObject);
  const testFunc = obj.instance.exports.globaltest;
  testFunc();
})();