#  Copyright 2017-20, Oscar Dowson
# This Source Code Form is subject to the terms of the Mozilla Public License,
# v. 2.0. If a copy of the MPL was not distributed with this file, You can
# obtain one at http://mozilla.org/MPL/2.0/.

#=
    The code in this file runs the examples from the paper

    Dowson, O. and Kapelevich, L. (2020). SDDP.jl - a Julia package for
    stochastic dual dynamic programming. INFORMS Journal on Computing. To
    appear.
=#

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
