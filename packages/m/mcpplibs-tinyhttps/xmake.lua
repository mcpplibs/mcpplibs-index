package("mcpplibs-tinyhttps")

    set_homepage("https://github.com/mcpplibs/tinyhttps")
    set_description("Minimal C++23 HTTP/HTTPS client with SSE streaming support")
    set_license("Apache-2.0")

    add_urls(
        "https://github.com/mcpplibs/tinyhttps/archive/refs/tags/$(version).tar.gz",
        "https://github.com/mcpplibs/tinyhttps.git"
    )

    add_versions("0.2.0", "279d3363591fb62b7a7a788e9500eddb6b97a285e28030efea168a5dcf678f04")
    add_versions("0.1.0", "af7daa6a63f264070a1ac8fe42725713ba7ea54e58f1e8b8e190d1b4c58a0896")

    add_deps("mbedtls 3.6.1")

    on_load(function (package)
        package:add("links", "tinyhttps")
    end)

    on_install(function (package)
        local configs = {}
        import("package.tools.xmake").install(package, configs)
    end)
