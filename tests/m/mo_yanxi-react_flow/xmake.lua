add_requires("mo_yanxi-react_flow 0.1.0")

target("mo_yanxi-react_flow_test")
    set_kind("binary")
    set_languages("c++23")
    add_files("main.cpp")
    add_packages("mo_yanxi-react_flow")
    set_policy("build.c++.modules", true)