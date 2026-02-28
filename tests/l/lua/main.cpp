import std;
import mcpplibs.capi.lua;

int main() {
    auto L = lua::L_newstate();
    lua::L_openlibs(L);

    lua::L_dostring(L, "result = 6 * 7");
    lua::getglobal(L, "result");
    auto result = lua::tointeger(L, -1);
    std::println("6 * 7 = {}", result);

    lua::close(L);
    return 0;
}
