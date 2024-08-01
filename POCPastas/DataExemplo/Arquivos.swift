//
//  Arquivos.swift
//  POCPastas
//
//  Created by Gabriel Vicentin Negro on 30/07/24.
//

import Foundation

class Arquivos {
    
    static public func exemplos() -> [Arquivo] {
        var arquivos: [Arquivo] = []
        
        for i in 0...10 {
            arquivos.append(Arquivo(nome: "teste\(i+1)", conteudo: "teste\(i+1) conteúdo"))
        }
        
        return arquivos
    }
    
}
