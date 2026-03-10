package("llmapi")

    --set_kind("library", {headeronly = true})

    set_homepage("https://github.com/mcpplibs/llmapi")
    set_description("Modern C++ LLM API client with openai-compatible support")
    set_license("Apache-2.0")

    add_urls(
        -- https://github.com/mcpplibs/llmapi/archive/refs/tags/0.0.1.tar.gz
        "https://github.com/mcpplibs/llmapi/archive/refs/tags/$(version).tar.gz",
        "https://github.com/mcpplibs/llmapi.git"
    )

    add_versions("0.1.0", "f01f5b0b6d11242b655f7c383e82a71e30a7696cdf4468d7ab3a3ae72f99b3e5")
    add_versions("0.0.1", "174f86d3afdf48a57ad1cc9688718d1f1100a78a7e56686c823c573c3ccf99f4")

    add_includedirs("include")
    add_deps("mbedtls 3.6.1")

    on_load(function (package)
        package:add("links", "llmapi")
        package:add("links", "tinyhttps")
    end)

    on_install(function (package)
        local configs = {}
        import("package.tools.xmake").install(package, configs, {target = "tinyhttps"})
        import("package.tools.xmake").install(package, configs, {target = "llmapi"})
    end)
