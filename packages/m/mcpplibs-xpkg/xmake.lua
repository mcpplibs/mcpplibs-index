package("mcpplibs-xpkg")

    set_homepage("https://github.com/Sunrisepeak/libxpkg")
    set_description("C++23 reference implementation of the xpkg package specification")
    set_license("MIT")

    add_urls(
        "https://github.com/Sunrisepeak/libxpkg/archive/refs/tags/v$(version).tar.gz",
        "https://github.com/Sunrisepeak/libxpkg.git v$(version)"
    )

    add_versions("0.0.2", "8861e0e53acce413be48ee58e7e6c8e2e9c0b8066bef05d15d911757f24944bc")
    add_versions("0.0.1", "4bbf178c9225e6be09302408ebe70edfdae237adbf142ddf10d1535aec2ae0cd")

    add_deps("mcpplibs-capi-lua")

    on_install(function (package)
        local configs = {}
        local install = import("package.tools.xmake").install
        -- Install each library target individually to avoid building examples/tests
        install(package, configs, {target = "mcpplibs-xpkg"})
        install(package, configs, {target = "mcpplibs-xpkg-loader"})
        install(package, configs, {target = "mcpplibs-xpkg-index"})
        install(package, configs, {target = "mcpplibs-xpkg-lua-stdlib"})
        install(package, configs, {target = "mcpplibs-xpkg-executor"})
    end)
