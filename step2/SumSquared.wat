(module
 (type $i32_i32_=>_i32 (func (param i32 i32) (result i32)))
 (export "SumSquared" (func $0))
 (func $0 (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local.set $2
   (i32.add
    (local.get $0)
    (local.get $1)
   )
  )
  (i32.mul
   (local.get $2)
   (local.get $2)
  )
 )
)
