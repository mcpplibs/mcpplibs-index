# mcpplibs-index

mcpplibs index

## How to use?

```lua
-- 0 - Add mcpplibs's index repos
add_repositories("mcpplibs-index git@github.com:mcpplibs/mcpplibs-index.git")

-- 1 - Add the libraries and versions you need
add_requires("templates 0.0.1")
--add_requires("mcpplibs-index@templates 0.0.1")

target("templates_test")
    set_kind("binary")
    set_languages("c++23")
    add_files("main.cpp")
    -- 2 - Use it
    add_packages("templates")
    set_policy("build.c++.modules", true)
```

## List

| name | introduce | demo | other |
| --- | --- | --- | --- |
| [templates](https://github.com/mcpplibs/templates) | A template of modern C++ `modules` libraries | [templates_test](tests/t/templates) | |
| [llmapi](https://github.com/mcpplibs/llmapi) | Modern C++ LLM API client with openai-compatible support | [llmapi_test](tests/l/llmapi) | |

## Other

- [mcpplibs](https://github.com/mcpplibs)
- [mcpp-community](https://github.com/mcpp-community)