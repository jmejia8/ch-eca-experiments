using Metaheuristics
using CEC17

function fitnessFunc(x)
    f, g, h = cec17_test_COP(x, func_num)
end

function runn(func_num)
    D = 10
    K = 7


    approx, ff = eca(fitnessFunc, D;
                                  N = 2K*D,
                              η_max = 2.0,
                             limits = [-100.0, 100],
                         correctSol = false,
                        showResults = false,
                        termination = x-> abs(std(-1 + 1.0 ./x)) < 1e-10,
                          max_evals = 10000D)

    return ff
end

function main()
    nfuns = 28
    nruns = 1
    
    for f = 1:nfuns
        errores = zeros(nruns)
        
        for r = 1:nruns
            err = runn(f)
            @printf("run = %d \t fn = %d \t error = %e \n", r, f, err)
            errores[r] = err
        end
        
        println("mean = ",mean(errores), " std = ", std(errores))
        println("====================================\n")
    end
end


main()