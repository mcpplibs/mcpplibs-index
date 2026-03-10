package("mcpplibs-tinyhttps")

    set_homepage("https://github.com/mcpplibs/tinyhttps")
    set_description("Minimal C++23 HTTP/HTTPS client with SSE streaming support")
    set_license("Apache-2.0")

    add_urls(
        "https://github.com/mcpplibs/tinyhttps/archive/refs/tags/$(version).tar.gz",
        "https://github.com/mcpplibs/tinyhttps.git"
    )

    add_versions("0.2.0", "022c5911b4199a80059579ad29a49b8e3312edf10e85e7cc961a4234106da70b")
    add_versions("0.1.0", "af7daa6a63f264070a1ac8fe42725713ba7ea54e58f1e8b8e190d1b4c58a0896")

    add_deps("mbedtls 3.6.1")

    on_load(function (package)
        package:add("links", "tinyhttps")
    end)

    on_install(function (package)
        local configs = {}
        import("package.tools.xmake").install(package, configs)
    end)
