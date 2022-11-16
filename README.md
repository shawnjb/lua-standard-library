# Lua Standard Library

Implement popular data structures & algorithms into your Lua applications. This repository is a completely rewritten version of the portuguese version, which can be found [here](https://github.com/tomieiro/LuaSTDL).

<p>
  <img src="https://www.andreas-rozek.de/Lua/Lua-Logo_32x32.png" alt="lua_logo" width="24px" />  Lua: https://www.lua.org/
</p>

## Motivation

Creating an independant and open source repository with various data structures that are implemented in Lua. The idea of the project was to expand the library through contributions & suggestions.

## Contributing

Everyone is allowed to contribute. Just open an issue, create a fork & submit a pull request. Read the [contribution guidelines](./CONTRIBUTING.md) for all details regarding this process.

## Usage

The use of the structures & algorithms is quite easy. Clone the repository to your project folder, and import & instantiate the structure class.

An example of using an algorithm would be the following:

```lua
local algorithm = require("algorithm")

local array = {1, 3, 7, 4, 6, 9, 8, 5}
print(table.concat(array, algorithm(array)))
```

An example of using a structure would be the following:

```lua
local structure = require("structure")
local object = structure:new()

object:insert(...)

print("The object contains " .. object:count() .. " elements.")
```

Please refer to the documentation for detailed information on what is available and what can be used. The files support lua documentation snippets & work best with [Sumneko's Lua Language Server extension](https://github.com/sumneko/lua-language-server).

## Documentation

The documentation is generated by LDoc. You can view either the [algorithms documentation](https://shawnjb.github.io/lua-standard-library/docs/algorithms) or the [structures documentation](https://shawnjb.github.io/lua-standard-library/docs/structures).