add_requires("llmapi 0.0.2")

target("llmapi_test")
    set_kind("binary")
    add_languages("c++23")
    add_files("main.cpp")
    add_packages("llmapi")
    set_policy("build.c++.modules", true)