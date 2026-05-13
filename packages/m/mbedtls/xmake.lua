package("mbedtls")
    set_homepage("https://tls.mbed.org")
    set_description("An open source, portable, easy to use, readable and flexible TLS library, and reference implementation of the PSA Cryptography API")
    set_license("Apache-2.0")

    add_urls("https://github.com/Mbed-TLS/mbedtls/releases/download/$(version).tar.bz2", {version = function (version)
        return string.format("mbedtls-%s/mbedtls-%s", version:sub(2), version:sub(2))
    end})
    add_urls("https://github.com/Mbed-TLS/mbedtls/archive/refs/tags/$(version).zip")
    add_urls("https://github.com/Mbed-TLS/mbedtls.git")

    add_versions("v3.6.1", "fc8bef0991b43629b7e5319de6f34f13359011105e08e3e16eed3a9fe6ffd3a3")

    add_deps("cmake")

    add_links("mbedtls", "mbedx509", "mbedcrypto")

    if is_plat("windows", "mingw") then
        add_syslinks("ws2_32", "advapi32", "bcrypt")
    elseif is_plat("linux", "bsd") then
        add_syslinks("pthread")
    end

    on_install(function (package)
        if package:config("shared") and package:is_plat("windows") then
            io.replace("library/constant_time_impl.h", "extern volatile", "__declspec(dllimport) volatile", {plain = true})
            io.replace("include/mbedtls/x509_crt.h", "extern const mbedtls_x509_crt_profile mbedtls_x509_crt_profile_suiteb;", "__declspec(dllimport) const mbedtls_x509_crt_profile mbedtls_x509_crt_profile_suiteb;", {plain = true})
            io.replace("include/mbedtls/x509_crt.h", "extern const mbedtls_x509_crt_profile mbedtls_x509_crt_profile_default;", "__declspec(dllimport) const mbedtls_x509_crt_profile mbedtls_x509_crt_profile_default;", {plain = true})
            io.replace("library/psa_util_internal.h", "extern const mbedtls_error_pair_t psa_to_ssl_errors[7];", "__declspec(dllimport) const mbedtls_error_pair_t psa_to_ssl_errors[7];", {plain = true})
        end

        local configs = {"-DENABLE_TESTING=OFF", "-DENABLE_PROGRAMS=OFF", "-DMBEDTLS_FATAL_WARNINGS=OFF"}
        table.insert(configs, "-DCMAKE_BUILD_TYPE=" .. (package:is_debug() and "Debug" or "Release"))
        if package:config("shared") then
            table.insert(configs, "-DUSE_SHARED_MBEDTLS_LIBRARY=ON")
            table.insert(configs, "-DUSE_STATIC_MBEDTLS_LIBRARY=OFF")
            if package:is_plat("windows") then
                table.insert(configs, "-DCMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=ON")
            end
        else
            table.insert(configs, "-DUSE_SHARED_MBEDTLS_LIBRARY=OFF")
            table.insert(configs, "-DUSE_STATIC_MBEDTLS_LIBRARY=ON")
        end

        local cxflags
        if package:is_plat("mingw") and package:is_arch("i386") then
            cxflags = {"-maes", "-msse2", "-mpclmul"}
        end
        import("package.tools.cmake").install(package, configs, {cxflags = cxflags})
    end)

    on_test(function (package)
        assert(package:has_cfuncs("mbedtls_ssl_init", {includes = "mbedtls/ssl.h"}))
        assert(package:check_cxxsnippets({test = [[
            void test() {
                mbedtls_aes_context ctx;

                unsigned char key[32];
                mbedtls_aes_setkey_enc(&ctx, key, 256);
            }
        ]]}, {includes = "mbedtls/aes.h"}))
    end)
