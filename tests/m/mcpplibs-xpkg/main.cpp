import std;
import mcpplibs.xpkg;

int main() {
    mcpplibs::xpkg::Package pkg;
    pkg.name = "test";
    pkg.description = "mcpplibs-xpkg smoke test";
    std::println("package: {} - {}", pkg.name, pkg.description);
    return 0;
}
