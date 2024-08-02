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
    
    init() {
        // Inicializo meu caminho com a pasta raiz
        if let pastaAberta = self.pastaAberta {
            self.caminho.push(pastaAberta)
        }
    }
    
    
    func abrirPasta(pasta: Pasta2) {
        withAnimation(.easeIn(duration: 0.1)) {
            // A pasta que o usuário abriu vira a pasta aberta
            self.pastaAberta = pasta
            
            // Adiciono no meu Caminho a pasta que foi aberta
            self.caminho.push(pasta)
        }
    }
    
    func abrirArquivo(arquivo: ArquivoPDF) {
        withAnimation(.easeIn(duration: 0.1)) {
            // Pasta aberta recebe nil pois não há nenhuma pasta aberta
            self.pastaAberta = nil
            
            // O arquivo que o usuário abriu vira o arquivo aberto
            self.arquivoAberto = arquivo
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
    
    func fecharArquivo() {
        withAnimation(.easeIn(duration: 0.1)) {
            // Arquivo aberto recebe nulo, ja que nao tem mais arquivo aberto
            self.arquivoAberto = nil
            
            // A pasta aberta é a pasta no maior topo da pilha, na verdade ja seria pois eu nao adiciono arquivos no caminho, entao nem precisa dessa linha, mas vou deixar ai
            self.pastaAberta = caminho.top()
        }
    }
}
