# Elixp

An attempt at a Lisp interpreter. Using the paper ["The Roots of Lisp"](http://languagelog.ldc.upenn.edu/myl/llog/jmc.pdf) as a reference.
Doesn't do side effects.

## Development

Run `iex -S mix` to open a repl. 

Run `mix test` to run the tests. 

Compile with `mix compile`.

### Debugger example
Below is an example of how to set a breakpoint to line 51 in the eval module and
then calling a function.

Start repl with `iex -S mix` and enter
```
:debugger.start()
:int.ni(Eval)
:int.break(Eval, 17)
Eval.init(["+", 1, 2, ["+", 3, 4], ["+", 5, 6], 7])
``` 
