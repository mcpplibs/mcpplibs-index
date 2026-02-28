add_requires("templates 0.0.1")
--add_requires("mcpplibs-index::templates 0.0.1") -- TODO: impl prefix support in xmake

target("templates_test")
    set_kind("binary")
    set_languages("c++23")
    add_files("main.cpp")
    add_packages("templates")
    set_policy("build.c++.modules", true)