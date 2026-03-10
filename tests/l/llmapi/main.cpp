import std;
import mcpplibs.llmapi;

int main() {
    using namespace mcpplibs::llmapi;

    auto client = Client(Config{
        .apiKey = "test-key",
        .model = "gpt-4o-mini",
    });

    client.system("You are a helpful assistant.");
    client.user("In one sentence, introduce modern C++.");

    std::println("llmapi {}", VERSION);
    return client.conversation().size() == 2 ? 0 : 1;
}
