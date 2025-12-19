package("templates")

    --set_kind("library", {headeronly = true})

    set_homepage("https://github.com/mcpplibs/templates")
    set_description("A template of modern C++ `modules` libraries")
    set_license("Apache-2.0")

    add_urls(
        -- https://github.com/mcpplibs/templates/archive/refs/tags/0.0.1.tar.gz
        "https://github.com/mcpplibs/templates/archive/refs/tags/$(version).tar.gz",
        "https://github.com/mcpplibs/templates.git"
    )

    add_versions("0.0.1", "f0833b18f9919ee187b8c63f8a47d1eb71382cb662805529a5e6ce1804b5335a")

    on_install(function (package)
        import("package.tools.xmake").install(package)
    end)