add_repositories("mcpplibs-index git@github.com:mcpplibs/mcpplibs-index.git")

add_requires("llmapi 0.0.1", {configs = { capi = true }})

target("llmapi_test_c")
    set_kind("binary")
    add_files("main.c")
    add_packages("llmapi")