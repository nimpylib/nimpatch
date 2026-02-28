## .. note:: This file is for doc only
when defined(nimdoc):
  import std/os
  import std/macros
  macro import_all(dir) =
    result = newNimNode nnkImportStmt
    let imps = newNimNode nnkBracket
    let s = dir.strVal
    let d = currentSourcePath() /../ s
    for (k, f) in walkDir d:# & "/*.nim":
      imps.add ident f.lastPathPart
    result.add infix(dir, "/", imps)
    echo repr result
  import_all nimpatch

