<h1><img src="https://asset.brandfetch.io/idpR3qNoyU/id_LDWZ-VP.svg" alt="lua_logo" width="24px" /> Lua Standard Library</h1>

Implement popular data structures & algorithms into your Lua applications. This repository is a completely rewritten version of the portuguese version, which can be found [here](https://github.com/tomieiro/LuaSTDL).

Interested in learning Lua? Try taking a [Codecademy course on Lua](https://www.codecademy.com/learn/learn-lua), or read the [official documentation](https://lua.org/).

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
