%Population Generation Function
function population = pop_generator(pop_size, boost_type, engine_type1, engine_type2, dia_eng1, dia_eng2, tar_alt)
population = [];
for i = 1:pop_size
    Ns = randi([1,4]);
    Nb = randi([0,6]);
    if Nb>0
        B = boost_type(randi([1,32]));
    else
        B = 0;
    end
    S1E = engine_type1(randi([1,46]));
    S1N = randi([1,50]);
    S1D = dia_eng1(S1E-100);
    S2E = zeros([1,4]);
    S2N = zeros([1,4]);
    S2D = zeros([1,4]);
    if Ns>1
        S2E(1) = engine_type2(randi([1,40]));
        S2N(1) = randi([1,50]);
        S2D(1) = dia_eng2(S2E(1)-200);
        if Ns>2
            S2E(2) = engine_type2(randi([1,40]));
            S2N(2) = randi([1,50]);
            S2D(2) = dia_eng2(S2E(2)-200);
            if Ns>3
                S2E(3) = engine_type2(randi([1,40]));
                S2N(3) = randi([1,50]);
                S2D(3) = dia_eng2(S2E(3)-200);
                if Ns>4
                    S2E(4) = engine_type2(randi([1,40]));
                    S2N(4) = randi([1,50]);
                    S2D(4) = dia_eng2(S2E(4)-200);
                end
            end
        end
    end
    maxD = dia_calculator(S1D, S2D(1), S2D(2), S2D(3), S2D(4), S1N, S2N(1), S2N(2), S2N(3), S2D(4));
    A = randi([1,20000]);
    genome = [Ns Nb B S1E S1N S2E(1) S2N(1) S2E(2) S2N(2) S2E(3) S2N(3) S2E(4) S2N(4) A maxD S1D S2D(1:4)];
    population = [population;genome];
end
function [maxD] = dia_calculator(dia1, dia2, dia3, dia4, dia5, n1, n2, n3, n4, n5)
        dias = [dia1, dia2, dia3, dia4, dia5];
        nl = [n1, n2, n3, n4, n5];
        D = zeros([1,5]);
        for k = 1:length(dias)
            r = dias(k)/2;
            D(k) = ((2*r)/(1-(tan(pi/4 - pi/(2*nl(k))))^2))*2;
        end
        maxD = max(D);
    end
end

