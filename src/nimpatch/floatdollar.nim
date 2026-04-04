
import ./utils
addPatch(((2,3,1), (2,2,3)), defined(js)):
  # fixes in nim-lang/Nim#24695
  from std/math import isNaN
  func isFinite(x: float): bool{.importc.} # importjs requires a pattern
  proc `$`*(x: SomeFloat): string =
    if isNaN(x): "nan"
    elif not isFinite(x):
      if x > 0: "inf" else: "-inf"
    else: system.`$` x

when not hasBug:
  when defined(nimPreviewSlimSystem):
    import std/formatfloat
    proc `$`*(x: SomeFloat): string = formatfloat.`$`(x)
  else:
    proc `$`*(x: SomeFloat): string = system.`$`(x)
