package("mcpplibs-xpkg")

    set_homepage("https://github.com/openxlings/libxpkg")
    set_description("C++23 reference implementation of the xpkg package specification")
    set_license("MIT")

    add_urls(
        "https://github.com/openxlings/libxpkg/archive/refs/tags/v$(version).tar.gz",
        "https://github.com/openxlings/libxpkg.git v$(version)"
    )

    add_versions("0.0.36", "9a077dd1d9654580b786857ccfb5f8195ed04179654344b348146da5d23cbade")
    add_versions("0.0.35", "b2de0a7721fc6ca58ac735f07ba4fef6e5ba52840eb1ba74258dcc9afc3959d3")
    add_versions("0.0.34", "5e5e1d2e220e36eae1ecfc0237ad30d956e02c4f0ac651f64189d5ed86fb1c1f")
    add_versions("0.0.33", "aea0ddaa972e92ae24a2f4ae29ece3d60c34168b13d5c1567133d73f348532d8")
    add_versions("0.0.32", "27eb8a68ca84fb0f084310d4c336498e9b5c6cc34fc857d59c5d93a3fd99f6c7")
    add_versions("0.0.31", "99ed585238c2f9f38fb7ebffc1ed61f30a5ea4a10a307032a8d3023d94a00da6")
    add_versions("0.0.30", "d878985ecbf61ece6b4d4b37b5d87863d89a6b21e0b4b38b98c65b8dc4d8b1bf")
    add_versions("0.0.29", "b7acf843677a80cc8725eb2b687f7b8152869bef9b651393f232907cd365e6b1")
    add_versions("0.0.28", "1f591812f1ae045a9673404f11b2cbee9c295067c5cb331c143defc6899ae5ca")
    add_versions("0.0.27", "ed00c1c1558850960c9aa19df978c0381070a92ad493f727e1be5bac0c320af5")
    add_versions("0.0.26", "03cf8fc360c463943000eef5d2f79bf3134d6003e96714bd36b486ccb512e2b7")
    add_versions("0.0.25", "70086636af8bcbdbfe313a4a3b0f5a4e7c7085bd227d460e75b5980ce1f88569")
    add_versions("0.0.24", "ed8660dbc4e4ceb42e20a6fa057a5252e8d2efcfba33ccac49a673e43d731752")
    add_versions("0.0.23", "62b672ac64a81e04643751fcd50cc1e969343e05031037f41ae00f6b788042c3")
    add_versions("0.0.22", "80bf1b09e30bdb49349073a1fa11f7e2f87edfe1a23c2ef99bc4d5e3aa2ed6c9")
    add_versions("0.0.17", "df115c0ad4644e5b9f6454fed2c3ed30f86c557482e375e42525192cfa8daf79")
    add_versions("0.0.16", "018882386436fb3c4b93d8459b745372bd9294cc1c76c10663b3881b4d78d260")
    add_versions("0.0.15", "b45b19f674018f3f9a8e9f96adef995e3a8af9f334a420263f549964751632c7")
    add_versions("0.0.14", "0db9b747e759535c66675bf58bcec1713c25f40bf70a199d7add1f6f717ef689")
    add_versions("0.0.13", "7a235167891c826d3bc5d358ad3c6352f1afe03577bb35ec05d266ac10c37ce6")
    add_versions("0.0.12", "d375d39ca0da36676c89d5a4727596a6f4434566eb56af53f2abf4d17abbc439")
    add_versions("0.0.11", "e91247c2eeb2d2810d5f469446f2684eeb265076dea082a58782d5876b968e34")
    add_versions("0.0.10", "2a3c1dff5171807082637173f23651c7d6e59367d886bff8b0eb2e8ccfdfcf5a")
    add_versions("0.0.9", "7dfe6fcb4e4c634439071267c4f582910d85fc319eb87abbf9686147a45e6141")
    add_versions("0.0.8", "b5b7fc34cd8eda2649f97963b1881dbaa373bc5768086b1a3f709a5bd646a028")
    add_versions("0.0.7", "1879ff5d027b7805df64f99a52ac8434f9e9f04f93f2cadd86526ac6ef1a985b")
    add_versions("0.0.6", "31eda109fa4d5c4131683f49e4983bb0a41322c541a96bec74dbb64e977284e6")
    add_versions("0.0.5", "1fb0148a836347ded2c9128b15c492fc25e8343393fb9afce6040a31c31293c9")
    add_versions("0.0.4", "d341e9fa144cbffa215528e6e8d690132d06895242cded1e5058227089622037")
    add_versions("0.0.3", "31631611985d4271b106f2c80d2cf7bc6d0f26ef5ffa5002a95e952a1012825c")
    add_versions("0.0.2", "8861e0e53acce413be48ee58e7e6c8e2e9c0b8066bef05d15d911757f24944bc")
    add_versions("0.0.1", "4bbf178c9225e6be09302408ebe70edfdae237adbf142ddf10d1535aec2ae0cd")

    add_deps("mcpplibs-capi-lua")

    on_install(function (package)
        local configs = {}
        local install = import("package.tools.xmake").install
        -- Install each library target individually to avoid building examples/tests
        install(package, configs, {target = "mcpplibs-xpkg"})
        install(package, configs, {target = "mcpplibs-xpkg-loader"})
        install(package, configs, {target = "mcpplibs-xpkg-index"})
        install(package, configs, {target = "mcpplibs-xpkg-lua-stdlib"})
        install(package, configs, {target = "mcpplibs-xpkg-executor"})
    end)
