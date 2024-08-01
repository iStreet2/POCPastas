//
//  Arquivo.swift
//  POCPastas
//
//  Created by Gabriel Vicentin Negro on 30/07/24.
//

import Foundation
import SwiftData

struct Arquivo: Identifiable, Hashable {
    
    var id = UUID()
    var nome: String
    var conteudo: String
    var url: URL?
    
    init(id: UUID = UUID(), nome: String, conteudo: String, url: URL? = nil) {
        self.id = id
        self.nome = nome
        self.conteudo = conteudo
        self.url = url
    }
    
    init() {
        self.nome = ""
        self.conteudo = ""
    }
}
