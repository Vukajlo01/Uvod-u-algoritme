const W = 1   
const G = 2   
const B = 3   

NAZIVI = ["Beograd   ", "Niš      ","Novi Sad   ", "Bečej     ", "Surdulica ", "B. Palanka  ", 
		  "Kragujevac", "Šid      ", "Kraljevo    ", "Šabac    ", "Čačak     ", "Obrenovac  "]

mutable struct Čvor
	id::Int64
	boja::Int8
	prethodni::Union{Nothing, Čvor}
	udaljenost::Float64
	susedi::Array{Int64, 1}
	težina::Array{Int64, 1}

	ImeGrada::String
end

Čvor(id::Int64) = Čvor(id, W, nothing, Inf, [], [], "")

mutable struct Graf
	V::Array{Čvor, 1}
end

Graf() = Graf(Array{Čvor, 1}())

function dodajVezeTežine!(Graf::Graf, MatricaSuseda::Array{Int64, 2})
	n = size(MatricaSuseda, 1)
	čvor_u = nothing
	for u in 1:n
		čvor_u = Čvor(u)
		for v in 1:n
			if u != v
				čvor_v = Čvor(v)
				težina = MatricaSuseda[u, v]
				if težina != 0
					push!(čvor_u.susedi, čvor_v.id)
					push!(čvor_u.težina, težina)
				end
			end
		end
		push!(Graf.V, čvor_u)
	end
end

function getTežina(Graf::Graf, u::Čvor, v::Čvor)
	i = 1
	for sused in u.susedi
		if v.id == sused
			težina = u.težina[i]
			return težina
		end
		i += 1
	end
end

function početneVrednosti!(Graf::Graf, sekundarni::Čvor)
	i = 1
	for u in Graf.V
		u.boja = W
		u.udaljenost = Inf
		u.prethodni = nothing
		u.ImeGrada = NAZIVI[i]		
		i += 1
	end
	sekundarni.udaljenost = 0
end

function relaksacija!(Graf::Graf, u::Čvor, v::Čvor)
	težina = getTežina(Graf, u, v)
	 
	if v.udaljenost > (u.udaljenost + težina) 
		v.udaljenost = u.udaljenost + težina  								
		v.prethodni = u

		return true
	end
	return false
end