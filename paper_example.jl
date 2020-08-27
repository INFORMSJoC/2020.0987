using SDDP, GLPK, Statistics
graph = SDDP.LinearGraph(3)
SDDP.add_edge(graph, 3 => 1, 0.95)
model = SDDP.PolicyGraph(
  graph, sense = :Min, lower_bound = 0.0, optimizer = GLPK.Optimizer
) do sp, t
  @variable(sp, 5 <= x <= 15, SDDP.State, initial_value = 10)
  @variable(sp, g_t >= 0)
  @variable(sp, g_h >= 0)
  @variable(sp, s >= 0)
  @constraint(sp, balance, x.out - x.in + g_h + s == 0)
  @constraint(sp, demand, g_h + g_t == 0)
  @stageobjective(sp, s + t * g_t)
  SDDP.parameterize(sp, [[0, 7.5], [3, 5], [10, 2.5]]) do w
    set_normalized_rhs(balance, w[1])
    set_normalized_rhs(demand, w[2])
  end
end
SDDP.train(model, iteration_limit = 100)
sims = SDDP.simulate(model, 100, [:g_t])
mu = round(mean([s[1][:g_t] for s in sims]), digits = 2)
println("On average, $(mu) units of thermal are used in the first stage.")
# output >>> On average, 2.37 units of thermal are used in the first stage.
V = SDDP.ValueFunction(model[1])
cost, price = SDDP.evaluate(V, x = 10)
# output >>> (233.53828121398493, Dict(:x=>-0.660014))
