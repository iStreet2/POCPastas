//
//  ViewModel.swift
//  POCPastas
//
//  Created by Gabriel Vicentin Negro on 30/07/24.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject {
    
    @Published public var arquivoAberto: ArquivoPDF?
    @Published public var pastaAberta: Pasta2?
    @Published public var caminho = Pilha()
    
    
    func abrirPasta(pasta: Pasta2) {
        withAnimation(.easeIn(duration: 0.1)) {
            // A pasta que o usuário abriu vira a pasta aberta
            self.pastaAberta = pasta
            
            // Adiciono no meu Caminho a pasta que foi aberta
            self.caminho.push(pasta)
        }
    }
    
    func fecharPasta() {
        withAnimation(.easeIn(duration: 0.1)) {
            // Retiro a ultima pasta do meu caminho
            let ultimaPasta = caminho.pop()
            print(ultimaPasta)
            // A pasta aberta vira o agora topo da pilha
            self.pastaAberta = caminho.top()
        }
        
    }
}
