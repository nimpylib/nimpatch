
const NimVersionTuple* = (NimMajor, NimMinor, NimPatch)
type
  Version = typeof NimVersionTuple
  Version2 = (Version, Version)

const JsBigInt64Option* = NimVersionTuple > (1, 6, 0) and compileOption("jsBigInt64")

proc `<=`(v: Version; v2: Version2): bool =
  v <= v2[0] and v <= v2[1]

template addPatch*(ver: Version|Version2,
    flag: untyped#[bool, use untyped to make flagExprRepr work]#,
    patchBody: untyped){.dirty.} =
  ##  flag is a bool expr, here uses untyped to delay evaluation
  ##   to get its string represent
  bind `<=`
  const
    FixedVer* = ver
    BeforeFixedVer* = NimVersionTuple <= FixedVer
    Flag = flag
    hasBug* = BeforeFixedVer and Flag
  when hasBug:
    patchBody
  else:
    const flagExprRepr = astToStr(flag)
    {.warning: currentSourcePath() & " patch only takes effect before " & $FixedVer &
      " or without flags: " & flagExprRepr.}
  
