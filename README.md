# mcpplibs-index

mcpplibs index

## How to use?

```lua
-- 0 - Add mcpplibs's index repos
add_repositories("mcpplibs-index git@github.com:mcpplibs/mcpplibs-index.git")

-- 1 - Add the libraries and versions you need
add_requires("mcpplibs-index@templates 0.0.1")

target("templates_test")
    set_kind("binary")
    set_languages("c++23")
    add_files("main.cpp")
    -- 2 - Use it
    add_packages("mcpplibs-index@templates")
    set_policy("build.c++.modules", true)
```