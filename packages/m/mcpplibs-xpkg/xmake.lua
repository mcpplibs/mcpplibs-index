package("mcpplibs-xpkg")

    set_homepage("https://github.com/Sunrisepeak/libxpkg")
    set_description("C++23 reference implementation of the xpkg package specification")
    set_license("MIT")

    add_urls(
        "https://github.com/Sunrisepeak/libxpkg/archive/refs/tags/$(version).tar.gz",
        "https://github.com/Sunrisepeak/libxpkg.git"
    )

    add_versions("0.0.1", "4bbf178c9225e6be09302408ebe70edfdae237adbf142ddf10d1535aec2ae0cd")

    add_deps("mcpplibs-capi-lua")

    on_install(function (package)
        local configs = {}
        import("package.tools.xmake").install(package, configs, {target = "xpkg"})
    end)
