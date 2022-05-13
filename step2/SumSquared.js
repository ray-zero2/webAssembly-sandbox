const fs = require('fs');
const bytes = fs.readFileSync(__dirname + '/SumSquared.wasm');
const value1 = parseInt(process.argv[2]);
const value2 = parseInt(process.argv[3]);

(async() => {
  const obj = await WebAssembly.instantiate(new Uint8Array(bytes));
  const sumSquaredFunc = obj.instance.exports.SumSquared;
  const result = sumSquaredFunc(value1, value2);
  console.log({ result });
})()