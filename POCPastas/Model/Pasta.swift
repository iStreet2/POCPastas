//
//  Pasta.swift
//  POCPastas
//
//  Created by Gabriel Vicentin Negro on 30/07/24.
//

import Foundation
import SwiftData

struct Pasta: Identifiable, Hashable {
    
    var id = UUID().uuidString
    var nome: String
    var pastas: [Pasta]?
    var arquivos: [Arquivo]?
    var arquivosPDF: [ArquivoPDF]?
    
    init(id: String = UUID().uuidString, nome: String, pastas: [Pasta]? = nil, arquivos: [Arquivo]? = nil, arquivosPDF: [ArquivoPDF]? = nil) {
        self.id = id
        self.nome = nome
        self.pastas = pastas
        self.arquivos = arquivos
        self.arquivosPDF = arquivosPDF
    }
    
    
    init() {
        self.id = "0"
        self.nome = "Raiz"
        
        //MARK: APENAS EXEMPLO, TIRAR ISSO DEPOOOOOOIIISSS
        self.arquivos = Arquivos.exemplos()
        self.pastas = Pastas.exemplos()
    }
}
