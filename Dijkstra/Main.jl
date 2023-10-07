include("graf.jl")
include("Dijkstra.jl")

using Printf

mutable struct ListaČvoraZaIspis
    idČvora::Int64
    udaljenost::String
end

rezultati = []

function inicijalizuj_početne_vrednosti()
    M = [ 0 15 14 10 11 6 0 2 0 0 0 0;
          0 0 2 0 0 0 0 0 0 10 54 36;
          0 0 0 5 0 0 0 0 0 0 0 0;
          0 0 0 0 1 0 0 0 0 0 0 0;
          0 0 0 0 0 0 0 0 0 0 0 0;
          0 0 0 0 4 0 1 0 0 0 0 0;
          0 0 0 0 0 0 0 0 0 0 0 0;
          0 9 0 0 0 3 8 0 5 0 0 0;
          0 3 0 0 0 0 0 0 0 2 0 0;
          0 0 0 0 0 0 0 0 0 0 0 0;
          0 0 9 0 0 0 0 0 0 1 0 0;
          0 0 5 0 0 0 0 0 0 0 1 0]
    
    g = Graf();

    dodajVezeTežine!(g, M)
    return g
end

function unos_broja()
    unos = 0
    while unos < 1 || unos > 12
        print("UNESITE POČETNI (REFERENTI) ČVOR X: ")
        str = readline(stdin)
        ucitano = 0
    
        try
            ucitano = parse(Int32, str)
        catch
            global unos = 0
        end

        unos = ucitano
    end
    
    println()
    return unos
end

function ispis_razdaljina(g, udaljeni)
    println(" ---------------------------------------")
    @printf(" |  ČVOR       %25s\n", "     UDALJENOST  |")
    println(" ---------------------------------------")

    i = 1
    for u in g.V
        udaljenost = string(@sprintf(" |  ČVOR[%02i]\t %-5s\t %20.2f  |\n", u.id, u.ImeGrada, udaljeni[i]))
        push!(rezultati, ListaČvoraZaIspis(u.id, udaljenost))
        i += 1
    end

    for i in 1:length(rezultati)
        @printf("%s", rezultati[i].udaljenost)
    end
    println(" ---------------------------------------")
end

# Inicijalizacija grafa, dodavanje veza i težina
g = inicijalizuj_početne_vrednosti()

# Unos referentog čvora
unos = unos_broja()

# Dijkstra algoritam (prilagođen)
g, udaljeni = Dijkstra!(g, Int32(unos), Int32(6))

# Ispis razdaljina
ispis_razdaljina(g, udaljeni)
#println("\n UDALJENOSTI U ODNOSU NA REFEREN. ČVOR $(unos).")
