## fixed in #25597

import ./utils
import std/parseutils

addPatch((2,3,1), true):
  from std/strutils import toLowerAscii
  func parseFloat*(a: openArray[char], res: var BiggestFloat): int =
    if a.len >= 4 and a[0] == '-':
      if a[1].toLowerAscii == 'n' and
         a[2].toLowerAscii == 'a' and
         a[3].toLowerAscii == 'n':
        res = -NaN
        return 4
    when nimvm:
      # NIM-BUG: https://github.com/nim-lang/Nim/issues/23936
      # bypass
      #  fixed on stable 2.0.10, devel 2.1.9
      parseutils.parseFloat(a.toOpenArray(0, a.high), res)
    else:
      parseutils.parseFloat(a, res)

when not hasBug:
  export parseFloat

