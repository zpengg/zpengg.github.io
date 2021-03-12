# SourceFile

```go
SourceFile = PackageClause ";" { ImportDecl ";" } { TopLevelDecl ";" } .

"json.go": SourceFile {
    PackageName: "json",
    ImportDecl: []Import{
        "io",
    },
    TopLevelDecl: ...
}
```

