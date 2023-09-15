object reg {
	// variables para la solución con 2 listas
	var property cantAbatidos = []
	var diasAbatidos = []

	// métodos para la solución usando 2 listas 
	
	method agregarAbatidosDia(cantidad,dia) {
		if(diasAbatidos.contains(dia)) self.error("Ya existe el día en el registro")
		cantAbatidos.add(cantidad)
		diasAbatidos.add(dia)
	}
	
	method agregarAbatidosVariosDias(listaCant,listaDias) {
		if(!diasAbatidos.asSet().intersection(listaDias.asSet()).isEmpty()) {
			self.error("Ya existe alguno de los días que se quiere agregar")
		}
		cantAbatidos.addAll(listaCant)
		diasAbatidos.addAll(listaDias)
	}
	
	method posicionDelDia(dia) {
		var posicion = 0
		(0..diasAbatidos.size()-1).forEach({i=>if(diasAbatidos.get(i)==dia) posicion=i})
		return posicion
	}
	
	method eliminarElRegistroDelDia(dia) {
		if(!diasAbatidos.contains(dia)) {self.error("No existe el día en el registro")}
		cantAbatidos = 
			cantAbatidos.take(self.posicionDelDia(dia)) + cantAbatidos.drop(self.posicionDelDia(dia)+1)
		diasAbatidos.remove(dia)
	}
	
	method eliminarLosRegistrosDeDias(listaDias) {
		listaDias.forEach({d => self.eliminarElRegistroDelDia(d)})
	}
	
	method cantidadDeDiasRegistrados() = diasAbatidos.size()
	method estaVacioElRegistro() = diasAbatidos.isEmpty()
	method algunDiaAbatio(cantidad) = cantAbatidos.contains(cantidad)
	method primerValorDeAbatidos() = cantAbatidos.first()
	method ultimoValorDeAbatidos() = cantAbatidos.last()
	method maximoValorDeAbatidos() = cantAbatidos.max()
	method totalAbatidos() = cantAbatidos.sum()
	method cantidadDeAbatidosElDia(dia) = cantAbatidos.get(self.posicionDelDia(dia))
	method ultimoValorDeAbatidosConSize() = cantAbatidos.get(cantAbatidos.size()-1)
	method diasConAbatidosSuperioresA(cuanto) = diasAbatidos.filter({
		dia => cantAbatidos.get(self.posicionDelDia(dia)) > cuanto
	})
	method valoresDeAbatidosPares() = cantAbatidos.filter({c => c.even()})
	method elValorDeAbatidos(cantidad) = cantAbatidos.find({c => c == cantidad})
	method abatidosSumando(cantidad) = cantAbatidos.map({c => c + cantidad})
	method abatidosEsAcotada(n1,n2) = cantAbatidos.all({c => c.between(n1,n2)})
	method algunDiaAbatioMasDe(cantidad) = cantAbatidos.any({c => c > cantidad})
	method todosLosDiasAbatioMasDe(cantidad) = cantAbatidos.all({c => c > cantidad})
	method cantidadAbatidosMayorALaPrimera() = cantAbatidos.count({c => c > cantAbatidos.first()})
	method esCrack() {
		if(cantAbatidos.isEmpty()) self.error("No hay ningún registro de abatidos")
		if (cantAbatidos.size()<2) return false
		else return (1..cantAbatidos.size()-1).all({i => cantAbatidos.get(i) > cantAbatidos.get(i-1)})
	} 
	
	method agregarAbatidosDiaMod(cantidad,dia) {
		if(diasAbatidos.contains(dia)) {
			const pos = self.posicionDelDia(dia)
			cantAbatidos = (0..cantAbatidos.size()-1).map({
				i => if(i==pos) cantAbatidos.get(i) + cantidad else cantAbatidos.get(i)
			})
		}
		else {
			cantAbatidos.add(cantidad)
			diasAbatidos.add(dia)
		}
	}
	
	method ordenarRegistro() {
		if(cantAbatidos.size()>=2) {
			const indice = (0..diasAbatidos.size()-1).map({i=>i})
			indice.sortBy({a,b => diasAbatidos.get(a) < diasAbatidos.get(b)})
			cantAbatidos = indice.map({i => cantAbatidos.get(i)})
			diasAbatidos = indice.map({i => diasAbatidos.get(i)})
		}
	}
	
	method esCrackPlus() {
		self.ordenarRegistro()
		if(cantAbatidos.isEmpty()) self.error("No hay ningún registro de abatidos")
		if (cantAbatidos.size()<2) return false
		else return (1..cantAbatidos.size()-1).all({i => cantAbatidos.get(i) > cantAbatidos.get(i-1)})
	}

}