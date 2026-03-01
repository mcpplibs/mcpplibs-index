package("mcpplibs-capi-lua")

    set_homepage("https://github.com/mcpplibs/lua")
    set_description("C++23 module bindings for Lua 5.4 C API")
    set_license("Apache-2.0")

    add_urls(
        "https://github.com/mcpplibs/lua/archive/refs/tags/$(version).tar.gz",
        "https://github.com/mcpplibs/lua.git"
    )

    add_versions("0.0.2", "b08f0aa6f8c42dc279a217d0e6386a8c8491abf0ade2b14b993e8428fca34563")
    add_versions("0.0.1", "cd75cf95f193e782c9024e25a89fce99c820dc93930d7157a16f89f5a16b6521")

    add_deps("lua")

    on_install(function (package)
        local configs = {}
        import("package.tools.xmake").install(package, configs, {target = "mcpplibs-capi-lua"})
        os.cp("src/capi/lua_headers.h", package:installdir("include"))
    end)
