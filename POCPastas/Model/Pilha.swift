//
//  Pilha.swift
//  POCPastas
//
//  Created by Gabriel Vicentin Negro on 31/07/24.
//

import Foundation

struct Pilha: Identifiable, Hashable {
    
    var id = UUID()
    
    private var itens: [Pasta] = []
    
    func getItens() -> [Pasta] {
        return itens
    }
    
    func count() -> Int {
        return itens.count
    }
    
    func top() -> Pasta {
        guard let topElement = itens.last else { fatalError("Esta pilha está vazia. Erro no top") }
        return topElement
    }
    
    mutating func pop() -> Pasta {
        guard itens.last != nil else { fatalError("Esta pilha está vazia. Erro no pop") }
        return itens.removeLast()
    }
    
    mutating func push(_ pasta: Pasta) {
        itens.append(pasta)
    }
    
}
