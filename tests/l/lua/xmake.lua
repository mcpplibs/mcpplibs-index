add_requires("mcpplibs-capi-lua 0.0.1")

target("lua_test")
    set_kind("binary")
    add_languages("c++23")
    add_files("main.cpp")
    add_packages("mcpplibs-capi-lua")
    set_policy("build.c++.modules", true)
