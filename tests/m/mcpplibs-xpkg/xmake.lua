add_requires("mcpplibs-xpkg 0.0.1")

target("mcpplibs-xpkg_test")
    set_kind("binary")
    set_languages("c++23")
    add_files("main.cpp")
    add_packages("mcpplibs-xpkg")
    set_policy("build.c++.modules", true)
