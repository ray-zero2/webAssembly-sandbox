(module
  (import "js" "tbl" (table $tbl 4 anyfunc)) ;; Tableは現在１モジュールにつき１つまでのため、指定せずに自動でここが参照される。
  (import "js" "increment" (func $increment (result i32)))
  (import "js" "decrement" (func $decrement (result i32)))
  (import "js" "wasm_increment" (func $wasm_increment (result i32)))
  (import "js" "wasm_decrement" (func $wasm_decrement (result i32)))

  ;; Typeの名前はなんでもよい...？
  (type $returns_i32 (func (result i32)))
  (type $returns_i32_test (func (result i32)))

  (global $inc_ptr i32 (i32.const 0))
  (global $dec_ptr i32 (i32.const 1))
  (global $wasm_inc_ptr i32 (i32.const 2))
  (global $wasm_dec_ptr i32 (i32.const 3))
  (global $iter_num i32 (i32.const 10_000_000))

  ;;JS関数の間接呼び出しのパフォーマンス
  (func $js_table_test (export "js_table_test")
    (loop $inc_cycle
      (call_indirect (type $returns_i32_test) (global.get $inc_ptr))
      global.get $iter_num
      i32.le_u
      br_if $inc_cycle
    )
    (loop $dec_cycle
      (call_indirect  (type $returns_i32_test) (global.get $dec_ptr))
      global.get $iter_num
      i32.le_u
      br_if $dec_cycle
    )
  )

  ;;JS関数の直接呼び出しテスト
  (func $js_import_test (export "js_import_test")
    (loop $inc_cycle
      call $increment
      global.get $iter_num
      i32.le_u
      br_if $inc_cycle
    )
    (loop $dec_cycle
      call $decrement
      global.get $iter_num
      i32.le_u
      br_if $dec_cycle
    )
  )

  ;; WASMの間接呼び出しテスト
  (func $wasm_table_test (export "wasm_table_test")
    (loop $inc_cycle
      (call_indirect (type $returns_i32) (global.get $wasm_inc_ptr))
      global.get $iter_num
      i32.le_u
      br_if $inc_cycle
    )
    (loop $dec_cycle
      (call_indirect (type $returns_i32) (global.get $wasm_dec_ptr))
      global.get $iter_num
      i32.le_u
      br_if $dec_cycle
    )
  )

  ;; WASMの直接呼び出しテスト
  (func $wasm_import_test (export "wasm_import_test")
    (loop $inc_cycle
      call $wasm_increment
      global.get $iter_num
      i32.le_u
      br_if $inc_cycle
    )
    (loop $dec_cycle
      call $wasm_decrement
      global.get $iter_num
      i32.le_u
      br_if $dec_cycle
    )
  )
)