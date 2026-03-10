package("llmapi")

    set_homepage("https://github.com/mcpplibs/llmapi")
    set_description("Modern C++ LLM API client with openai-compatible support")
    set_license("Apache-2.0")

    add_urls(
        "https://github.com/mcpplibs/llmapi/archive/refs/tags/$(version).tar.gz",
        "https://github.com/mcpplibs/llmapi.git"
    )

    add_versions("0.2.1", "d48f0bd6b6186aac91f5a26e9a20bc59014f396e7589cf8a52dfd6790de31dab")
    add_versions("0.2.0", "2969d573cf50563159f74ac0a65ccaa05db86a5becf4786de6d6daeef8012d90")
    add_versions("0.1.0", "f01f5b0b6d11242b655f7c383e82a71e30a7696cdf4468d7ab3a3ae72f99b3e5")
    add_versions("0.0.1", "174f86d3afdf48a57ad1cc9688718d1f1100a78a7e56686c823c573c3ccf99f4")

    add_includedirs("include")
    add_deps("mcpplibs-tinyhttps 0.2.0")

    on_load(function (package)
        package:add("links", "llmapi")
    end)

    on_install(function (package)
        local configs = {}
        import("package.tools.xmake").install(package, configs, {target = "llmapi"})
    end)
