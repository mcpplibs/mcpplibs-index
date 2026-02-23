package("cmdline")

    set_homepage("https://github.com/mcpplibs/cmdline")
    set_description("A simple command-line parsing library/framework for modern C++")
    set_license("Apache-2.0")

    add_urls(
        "https://github.com/mcpplibs/cmdline/archive/refs/tags/$(version).tar.gz",
        "https://github.com/mcpplibs/cmdline.git"
    )

    on_install(function (package)
        import("package.tools.xmake").install(package)
    end)
