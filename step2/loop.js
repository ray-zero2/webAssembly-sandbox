const fs = require('fs');
const bytes = fs.readFileSync(__dirname + '/loop.wasm');

const n = parseInt(process.argv[2] || "1", 10);

const importObject = {
  env: {
    log: (n, factorial) =>{
      console.log(`${n}! = ${factorial}`);
    }
  }
};

(async () => {
  const obj = await WebAssembly.instantiate(new Uint8Array(bytes), importObject);
  const loop_test = obj.instance.exports.loop_test;
  const factorial = loop_test(n)
  console.log(`result: ${n}! = ${factorial}`);
})();