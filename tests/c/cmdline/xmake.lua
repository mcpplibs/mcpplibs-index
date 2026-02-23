add_repositories("mcpplibs-index https://github.com/mcpplibs/mcpplibs-index.git")

add_requires("cmdline", {system = false})

target("cmdline_test")
    set_kind("binary")
    set_languages("c++23")
    add_files("main.cpp")
    add_packages("cmdline")
    set_policy("build.c++.modules", true)
