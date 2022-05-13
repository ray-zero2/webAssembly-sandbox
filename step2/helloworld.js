const fs = require('fs');
const bytes = fs.readFileSync(__dirname + '/helloworld.wasm'); 

const start_string_index = 100;
const memory = new WebAssembly.Memory({ initial: 1 });

let importObject = {
  env: {
    buffer: memory,
    start_string: start_string_index,
    print_string: (str_len) => {
      const bytes = new Uint8Array(memory.buffer, start_string_index, str_len); 
      const log_string = new TextDecoder('utf8').decode(bytes);
      console.log(log_string);
    }
  }
};

(async () => {
   const obj = await WebAssembly.instantiate(new Uint8Array(bytes), importObject); 
   const helloFunc = obj.instance.exports.helloworld;
   helloFunc();
  }
)();
