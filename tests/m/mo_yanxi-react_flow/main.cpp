#include <mo_yanxi/adapted_attributes.hpp>

import mo_yanxi.react_flow;
import mo_yanxi.react_flow.common;

import std;

void benchmark_diamond_dag() {
    using namespace mo_yanxi::react_flow;
    constexpr std::uint32_t iterations = 1'000'000;

    // --- 1. React Flow 设置 ---
    manager mgr{manager_no_async}; // 禁用异步以单纯测试计算开销

    auto& p_a = mgr.add_node<provider_cached<double>>();
    auto& p_b = mgr.add_node<provider_cached<double>>();
    auto& p_c = mgr.add_node<provider_cached<double>>();

    auto& t_x = mgr.add_node(make_transformer([](double a, double b) {
        return a + b;
    }));
    auto& t_y = mgr.add_node(make_transformer([](double b, double c) {
        return b * c;
    }));
    auto& t_z = mgr.add_node(make_transformer([](double x, double y) {
        return std::sqrt(x * x + y * y);
    }));

    // 监听最终结果
    volatile double dummy_result = 0.0;
    auto& listener = mgr.add_node(make_listener([&](double z) {
        dummy_result = z;
    }));

    // 连接节点 (注意：transformer 的参数顺序对应 slot 的索引)
    p_a.connect_successor(0, t_x);
    p_b.connect_successor(1, t_x);

    p_b.connect_successor(0, t_y);
    p_c.connect_successor(1, t_y);

    t_x.connect_successor(0, t_z);
    t_y.connect_successor(1, t_z);

    t_z.connect_successor(0, listener);

    // 初始化基础数据
    p_a.update_value(10.0);
    p_c.update_value(5.0);

    // --- 2. Benchmark: Node Flow ---
    auto start_node = std::chrono::high_resolution_clock::now();
    for (std::uint32_t i = 0; i < iterations; ++i) {
        p_b.update_value(static_cast<double>(i)); // 触发整条链路的 update
    }
    auto end_node = std::chrono::high_resolution_clock::now();

    // --- 3. Benchmark: 直接硬编码 ---
    auto start_direct = std::chrono::high_resolution_clock::now();
    double a = 10.0;
    double c = 5.0;
    for (std::uint32_t i = 0; i < iterations; ++i) {
        double b = static_cast<double>(i);
        double x = a + b;
        double y = b * c;
        dummy_result = std::sqrt(x * x + y * y);
    }
    auto end_direct = std::chrono::high_resolution_clock::now();

    // --- 输出结果 ---
    auto duration_node = std::chrono::duration_cast<std::chrono::milliseconds>(end_node - start_node).count();
    auto duration_direct = std::chrono::duration_cast<std::chrono::milliseconds>(end_direct - start_direct).count();

    std::println("=== Diamond DAG Benchmark ({} iterations) ===", iterations);
    std::println("React Flow Duration: {} ms", duration_node);
    std::println("Direct Code Duration: {} ms", duration_direct);
    std::println("Overhead Ratio: {:.2f}x", static_cast<double>(duration_node) / static_cast<double>(std::max<long long>(duration_direct, 1)));
}


int main(){
	benchmark_diamond_dag();
}