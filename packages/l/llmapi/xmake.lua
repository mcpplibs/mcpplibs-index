package("llmapi")

    set_homepage("https://github.com/mcpplibs/llmapi")
    set_description("Modern C++ LLM API client with openai-compatible support")
    set_license("Apache-2.0")

    add_urls(
        "https://github.com/mcpplibs/llmapi/archive/refs/tags/$(version).tar.gz",
        "https://github.com/mcpplibs/llmapi.git"
    )

    add_versions("0.2.6", "d4aedb04d695c6bbf5685fad79185642aec4a48e8b4211275b752294c3eb43cc")
    add_versions("0.2.5", "fffa1341beed98ace97e029c0e46f47f55470df6e6a7114374e73e2bfd13699f")
    add_versions("0.2.3", "1661960fd6752555dae58848257728e1808b5c096c2842bbf8a780393bf81b4a")
    add_versions("0.2.2", "014385091f4e9b84d42a6e00b8259552497949223d95c03558003bbb0990d904")
    add_versions("0.2.1", "d48f0bd6b6186aac91f5a26e9a20bc59014f396e7589cf8a52dfd6790de31dab")
    add_versions("0.2.0", "2969d573cf50563159f74ac0a65ccaa05db86a5becf4786de6d6daeef8012d90")
    add_versions("0.1.0", "f01f5b0b6d11242b655f7c383e82a71e30a7696cdf4468d7ab3a3ae72f99b3e5")
    add_versions("0.0.1", "174f86d3afdf48a57ad1cc9688718d1f1100a78a7e56686c823c573c3ccf99f4")

    add_includedirs("include")

    on_load(function (package)
        package:add("links", "llmapi")
        if package:version():ge("0.2.0") then
            package:add("deps", "mcpplibs-tinyhttps >=0.2.0")
        end
    end)

    on_install(function (package)
        local configs = {}
        import("package.tools.xmake").install(package, configs, {target = "llmapi"})
    end)
