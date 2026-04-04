{.used.}
import ./utils
addPatch((2,3,1), defined(js)):
  when compileOption("jsbigint64"):
    proc `/`*(x, y: BiggestInt): float{.importjs: "(#/#)".}
  else:
    proc `/`*(x, y: BiggestInt): float =
      system.`/`(float(x), float(y))

