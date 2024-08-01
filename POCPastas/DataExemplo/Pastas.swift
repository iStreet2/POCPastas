//
//  Pastas.swift
//  POCPastas
//
//  Created by Gabriel Vicentin Negro on 30/07/24.
//

import Foundation


class Pastas {
    
    static public func exemplos() -> [Pasta] {
        var pastas: [Pasta] = []
        
        let pastaLouca = Pasta(nome: "meu deeeeeus",arquivos: [Arquivo(nome: "holy shit", conteudo: "VAMOOOOOOOO")])
        
        for i in 0...3 {
            pastas.append(Pasta(nome: "teste\(i+1)"))
        }
        
        pastas.append(Pasta(nome: "alooo", pastas: [pastaLouca]))
        
        return pastas
    }
    
}
