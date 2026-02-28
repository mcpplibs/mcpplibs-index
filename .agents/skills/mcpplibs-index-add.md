---
name: mcpplibs-index-add
description: Add a new C++ library to the mcpplibs-index xmake package repository. Use when user provides a GitHub repo URL and wants to add it as a package.
---

# Add Library to mcpplibs-index

## Overview

This skill adds a new library from `https://github.com/mcpplibs/<name>` to the mcpplibs-index xmake package repository. The full workflow: gather info → create package definition → create test → verify build → commit & push.

## References

- xmake package docs: https://xmake.io/mirror/manual/package_dependencies.html
- mcpplibs org: https://github.com/mcpplibs
- index repo: https://github.com/mcpplibs/mcpplibs-index

## Step 1: Gather Library Info

From the given GitHub repo URL, collect:

1. **Repo description** — from GitHub page
2. **License** — typically Apache-2.0
3. **Latest release tag** — e.g. `0.0.1`
4. **Target name** — from the repo's `xmake.lua` (`target("xxx")`)
5. **Module name** — from `.cppm` files (`export module xxx`)
6. **Namespace** — from `.cppm` files (`export namespace xxx`)
7. **Dependencies** — from `add_requires()` in the repo's `xmake.lua`
8. **Extra headers** — any `.h` files referenced in `.cppm` that need manual install (e.g. `#include "xxx.h"` in module preamble)
9. **SHA256 of release tarball**:

```bash
curl -sL https://github.com/mcpplibs/<name>/archive/refs/tags/<version>.tar.gz | sha256sum
```

## Step 2: Determine Package Name

**Critical rule**: The package directory name MUST match the `package("xxx")` name exactly.

- If the target name is generic (e.g. same as an existing xmake package like `lua`), use a prefixed name like `mcpplibs-capi-lua` to avoid conflicts
- If the target name is unique (e.g. `llmapi`, `cmdline`), use it directly
- Directory path: `packages/<first-letter>/<package-name>/xmake.lua`

Examples:
- `llmapi` → `packages/l/llmapi/xmake.lua`
- `mcpplibs-capi-lua` → `packages/m/mcpplibs-capi-lua/xmake.lua`
- `cmdline` → `packages/c/cmdline/xmake.lua`

## Step 3: Create Package Definition

Create `packages/<first-letter>/<package-name>/xmake.lua`:

```lua
package("<package-name>")

    set_homepage("https://github.com/mcpplibs/<repo-name>")
    set_description("<description>")
    set_license("<license>")

    add_urls(
        "https://github.com/mcpplibs/<repo-name>/archive/refs/tags/$(version).tar.gz",
        "https://github.com/mcpplibs/<repo-name>.git"
    )

    add_versions("<version>", "<sha256>")

    -- add dependencies if any
    add_deps("<dep1>")

    on_install(function (package)
        local configs = {}
        -- If repo has examples/tests targets, specify library target only
        -- to avoid parallel C++23 std module compilation conflicts
        import("package.tools.xmake").install(package, configs, {target = "<target-name>"})
        -- If cppm files reference headers not installed by default, copy them manually
        -- os.cp("src/path/to/header.h", package:installdir("include"))
    end)
```

### Key Pitfalls

- **Target isolation**: If the upstream repo includes examples/tests via `includes()`, they will be built during package install. This causes parallel `std` module compilation conflicts with GCC. Fix: pass `{target = "<name>"}` as the 3rd argument to `install()`.
- **Missing headers**: C++20 modules using `#include` in the global module fragment need those headers installed. Check the `.cppm` files for `#include "xxx.h"` and add `os.cp(...)` in `on_install`.
- **Links**: If consumers need to link against specific libraries, add `on_load` with `package:add("links", "xxx")`.

## Step 4: Create Test

Create `tests/<first-letter>/<package-name>/xmake.lua`:

```lua
add_requires("<package-name> <version>")

target("<package-name>_test")
    set_kind("binary")
    add_languages("c++23")
    add_files("main.cpp")
    add_packages("<package-name>")
    set_policy("build.c++.modules", true)
```

**Do NOT** add `add_repositories()` here — it's handled by `tests/xmake.lua`.

Create `tests/<first-letter>/<package-name>/main.cpp` with a minimal usage example based on the library's examples or README.

## Step 5: Register Test in Top-Level

Add an `includes()` line to `tests/xmake.lua`:

```lua
includes("<first-letter>/<package-name>")
```

## Step 6: Verify Build

```bash
# Clean any cached package
rm -rf ~/.xmake/packages/<first-letter>/<package-name>

# Configure and install from tests/ directory
cd tests/
xmake f -y -c

# Build the specific test target
xmake build <package-name>_test

# Run it
xmake run <package-name>_test
```

All three commands must succeed before proceeding.

## Step 7: Create Branch, Commit & Push

```bash
git checkout -b add-<repo-name>-library
git add packages/<first-letter>/<package-name>/xmake.lua \
       tests/<first-letter>/<package-name>/xmake.lua \
       tests/<first-letter>/<package-name>/main.cpp \
       tests/xmake.lua
git commit -m "add <package-name> library"
git push -u upstream add-<repo-name>-library
```

Use `upstream` (SSH remote) for push, not `origin` (HTTPS, no auth).

## Checklist

- [ ] Package directory name == `package("xxx")` name
- [ ] SHA256 matches release tarball
- [ ] `on_install` specifies target if repo has examples/tests
- [ ] Extra headers copied in `on_install` if needed by cppm
- [ ] Test does NOT have `add_repositories()` (top-level handles it)
- [ ] Test registered in `tests/xmake.lua` via `includes()`
- [ ] `xmake build` succeeds
- [ ] `xmake run` produces expected output
- [ ] Committed and pushed to upstream
