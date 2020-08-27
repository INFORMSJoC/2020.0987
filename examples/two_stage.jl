using SDDP
using GLPK

function run_model(N, Ω)
    INITIAL_VALUE = rand(80.0:140, N)
    FUTURE_VALUE = rand(40.0:150.0, Ω, N)
    DEMAND = rand(40.0:50.0, Ω)
    model = SDDP.LinearPolicyGraph(
        stages = 2, sense = :Min, optimizer = GLPK.Optimizer, lower_bound = 0.0
    ) do sp, t
        @variable(sp, x[i =1:N] >=0, SDDP.State, initial_value = 0.0)
        if t == 1
            @constraint(sp, sum(x[i].out for i = 1:N) == 1)
            @stageobjective(sp, sum(INITIAL_VALUE[i] * x[i].out for i = 1:N))
        else
            @variable(sp, penalty >= 0)
            c = @constraint(sp, sum(x[i].in for i = 1:N) + penalty >= 0)
            SDDP.parameterize(sp, 1:Ω) do ω
                for i = 1:N
                    set_normalized_coefficient(c, x[i].in, FUTURE_VALUE[ω, i])
                end
                set_normalized_rhs(c, DEMAND[ω])
                ex = @expression(sp, sum(-FUTURE_VALUE[ω, i] * x[i].in for i = 1:N) + 100 * penalty)
                @stageobjective(sp, ex)
            end
        end
    end
    SDDP.train(
        model; risk_measure = SDDP.AVaR(0.05), iteration_limit = 100
    )
    sim = SDDP.simulate(model, 1, [:x])[1]
    return [sim[1][:x][i].out for i = 1:N]
end
run_model(5, 5)

nzthis = _hessian_slice(
    d,
    ex,
    x,
    H,
    obj_factor,
    nzcount,
    recovery_tmp_storage,
    Val{1},
)::Int
