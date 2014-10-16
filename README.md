OMake port to MinGW
======================

How to build:

Preparation
--------------

* ocaml and ocamlfind must be installed
* `export PREFIX=c:/ocamlmgw` or something equivalent
* `export CC=i686-w64-mingw32-gcc` or something equivalent


`mmtranslate`
---------------

C dependency analysis requires a program called `mmtranslate`,
to handle the output of `gcc -MM`.

NOTE: Currently `mmtranslate` in this repo is very simplified version
compared to the original 
`https://github.com/fdopen/godi-repo/blob/master/godi/godi-omake/files/mmtranslate/ohelper.ml`
and cannot handle file paths which do not start with `\`.
If you see the following message then `mmtranslate` is not properly working
and your build **may** fail:

```
mmtranslate: this mmtranslate cannot handle this path: <file path>
```

Build and install:

```shell
$ cd mmtranslate
$ make
$ make install
```

omake
---------------

```shell
$ cd ..       (to go back to the repo root)
$ make bootstrap
$ make all install
```

