package("mo_yanxi-react_flow")

    set_homepage("https://github.com/Yuria-Shikibe/mo_yanxi_react_flow")
    set_description("A lightweight, C++23 module-interface-only data graph publisher-receiver framework.")
    set_license("MIT")

    add_urls(
        "https://github.com/Yuria-Shikibe/mo_yanxi_react_flow/archive/refs/tags/$(version).tar.gz",
        "https://github.com/Yuria-Shikibe/mo_yanxi_react_flow.git", {
            excludes = {"*/properties/*, */test/*, */examples/*, */benchmark/*"}
        }
    )

    add_versions("0.1.0", "EA76859AEB414C124A52EF0B91007E8B0FD2527EF47EC129E12E34041EE049D4")

    if is_plat("windows") then
        set_policy("platform.longpaths", true)
    end

    add_includedirs("include")

    on_install(function (package)
        local configs = {add_test = false, add_benchmark = false}
        import("package.tools.xmake").install(package, configs)
    end)
