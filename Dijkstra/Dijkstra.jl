# Dijkstra.jl

function Dijkstra!(Graf::Graf, refČvor::Int32, KrajnjiGrad::Int32)    
    function pronadjiMinimum!(Q) 
        D = map(id -> Graf.V[id].udaljenost, Q)
        indeks = argmin(D)                 
        #id = Q[indeks]
        Q[indeks] = Q[end]
        pop!(Q)                          
        
        return indeks
    end  
                                           
    početneVrednosti!(Graf, Graf.V[refČvor]) 
    Graf.V[refČvor].boja = G
                                          
    S = []                                 
    Q = collect(keys(Graf.V))

    while length(Q) > 0
        u = Graf.V[pronadjiMinimum!(Q)]     
        u.boja = G
        push!(S, u)

        for sused in u.susedi
            v = Graf.V[sused]
            relaksacija!(Graf, u, v)  
        end
        u.boja = B

        if u.id == KrajnjiGrad
            if u.udaljenost == Inf
                println("GRAD NIJE POVEZAN!")
                break
            end
            tekst1  = split(Graf.V[refČvor].ImeGrada, " ")
            tekst2  = split(Graf.V[u.id].ImeGrada, " ")
            println("Put od $(tekst1[1]) do $(tekst2[1]): ")
            for i in 1:length(S)
                print(" $(S[i].ImeGrada) ")
            end
            println("")
            break
        end

    end

    function putanje(Graf)
        udaljeni = Float64[]
        for u in Graf.V
            push!(udaljeni, u.udaljenost)
        end
    
        return udaljeni
    end

    return Graf, putanje(Graf)
end