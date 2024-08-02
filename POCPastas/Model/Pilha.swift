//
//  Pilha.swift
//  POCPastas
//
//  Created by Gabriel Vicentin Negro on 31/07/24.
//

import Foundation

struct Pilha: Identifiable, Hashable {
    
    var id = UUID()
    
    private var itens: [Pasta2] = []
    
    func getItens() -> [Pasta2] {
        return itens
    }
    
    func count() -> Int {
        return itens.count
    }
    
    func top() -> Pasta2 {
        guard let topElement = itens.last else { fatalError("Esta pilha está vazia. Erro no top") }
        return topElement
    }
    
    mutating func pop() -> Pasta2 {
        guard itens.last != nil else { fatalError("Esta pilha está vazia. Erro no pop") }
        return itens.removeLast()
    }
    
    mutating func push(_ pasta: Pasta2) {
        itens.append(pasta)
    }
    
}
