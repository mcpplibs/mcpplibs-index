package("mcpplibs-tinyhttps")

    set_homepage("https://github.com/mcpplibs/tinyhttps")
    set_description("Minimal C++23 HTTP/HTTPS client with SSE streaming support")
    set_license("Apache-2.0")

    add_urls(
        "https://github.com/mcpplibs/tinyhttps/archive/refs/tags/$(version).tar.gz",
        "https://github.com/mcpplibs/tinyhttps.git"
    )

    add_versions("0.2.3", "67ff75050d31157d3c35562187c9fb622e66167c98bb950cebb51db9b07ebe97")
    add_versions("0.2.2", "bc4cb59475826a975dd0408b59a00cf41c4aa4078a0fc2e54929bde7fb696248")
    add_versions("0.2.0", "81dab607227f353fa83068d4fee47b6877ceff891719a60a9cd75eaf827fab44")
    add_versions("0.1.0", "af7daa6a63f264070a1ac8fe42725713ba7ea54e58f1e8b8e190d1b4c58a0896")

    on_load(function (package)
        package:add("links", "tinyhttps")
        package:add("deps", "mbedtls >=3.6.1")
    end)

    on_install(function (package)
        local configs = {}
        import("package.tools.xmake").install(package, configs, {target = "tinyhttps"})
    end)

    on_test(function (package)
        assert(package:check_cxxsnippets({test = [[
            import tinyhttps;
            void test() {
                tinyhttps::HttpRequest req;
                req.url = "https://example.com";
            }
        ]]}, {configs = {languages = "c++23"}}))
    end)
