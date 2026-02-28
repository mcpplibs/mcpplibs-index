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

    add_versions("0.0.1", "174f86d3afdf48a57ad1cc9688718d1f1100a78a7e56686c823c573c3ccf99f4")

    add_includedirs("include")
    add_deps("libcurl 8.11.0")

    on_load(function (package)
        package:add("links", "llmapi")
    end)

    on_install(function (package)
        import("package.tools.xmake").install(package)
    end)