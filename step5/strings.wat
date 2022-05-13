(module
  (import "env" "str_pos_len" (func $str_pos_len (param i32 i32)))
  (import "env" "null_str" (func $null_str (param i32)))
  (import "env" "len_prefix" (func $len_prefix (param i32)))
  (import "env" "buffer" (memory 1))

  (data (i32.const 0) "null-terminating string\00")
  (data (i32.const 128) "another null-terminatinv string\00")

  (data (i32.const 256) "know the length of this string")
  (data (i32.const 384) "Also knoe the length of this string")

  (data (i32.const 512) "\16length-prefixed string")
  (data (i32.const 640) "\1eanother length-prefixed string")

  (func $main (export "main")
    (call $null_str (i32.const 0))
    (call $null_str (i32.const 128))

    (call $str_pos_len (i32.const 256) (i32.const 30))
    (call $str_pos_len (i32.const 384) (i32.const 35))

    (call $len_prefix (i32.const 512))
    (call $len_prefix (i32.const 640))
  )

  (func $byte_copy
    (param $source i32) (param $dest i32) (param $len i32)
    (local $last_source_byte i32)

    i32.add (local.get $source) (local.get $len)
    local.set $last_souce_byte

  )
)