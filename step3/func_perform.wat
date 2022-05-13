(module
  (import "js" "external_call" (func $external_call (result i32)))

  (global $i (mut i32) (i32.const 0))

  (func $internal_call  (result i32)
    (i32.add (global.get $i) (i32.const 1))
    global.set $i
    global.get $i
  )

  (func $wasm_call (export "wasm_call")
    (loop $again
      (call $internal_call)
      i32.const 4_000_000
      i32.le_u
      br_if $again
    )
  )

  (func $js_call (export "js_call")
    (loop $again
      (call $external_call)
        i32.const 4_000_000
        i32.le_u
        br_if $again
    )
  )
)