REM | Generates Lua documentation for the project.

ldoc.lua "./algorithms" -d "./site/docs/algorithms" -o "index" -f "markdown"
ldoc.lua "./structures" -d "./site/docs/structures" -o "index" -f "markdown"