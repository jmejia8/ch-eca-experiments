using Metaheuristics
using CEC17

const NFUNS = 28
const NRUNS = 25
const ε     = 0.0001

function G(g)
    i = g .<= 0.0
    
    gg = copy(g)
    gg[i] = 0.0
    return gg
end

function H(h)
    hh = abs.(h) - ε

    i = h .<= 0.0
    hh[i] = 0.0
    return hh
end



function runn(func_num, run_num)
    D = 10
    K = 7

    f,g,h = cec17_test_COP(zeros(D), func_num)
    D_g = length(g)
    D_h = length(h)

    fitnessFunc(x) = cec17_test_COP(x, func_num)

    approx = ecaConstrained(fitnessFunc, D, D_g, D_h;
                              η_max = 2.0,
                             limits = searchRange(func_num),
                         correctSol = true,
                        showResults = false,
                            saveLast= "tmp/output/gen_f$(func_num)_$(run_num).csv",
                    saveConvergence = "tmp/output/converg_f$(func_num)_$(run_num).csv",
                          max_evals = 20000D)

    c = sum(G(approx.g) .> 0.0) + sum(H(approx.h) .> 0.0)
    return approx.f, approx.νVal, c
end

function main()
    
    nruns = NRUNS
    
    for f = 1:NFUNS
        
        for r = 2:nruns
            ff, v, c = runn(f, r)
            @printf("run = %d \t fnum = %d \t %e \t ν = %e \t c =  %d\n", r, f, ff, v,c)
        end
        
        println("====================================")
        # break
    end
end


main()