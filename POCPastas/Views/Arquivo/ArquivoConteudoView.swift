//
//  ArquivoAbertoView.swift
//  POCPastas
//
//  Created by Gabriel Vicentin Negro on 30/07/24.
//

import SwiftUI

//Nem vou usar mais, ja tenho o ShowPDFView
struct ArquivoConteudoView: View {
    
    @EnvironmentObject var vm: ViewModel
    
    var arquivo: Arquivo
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Text(arquivo.conteudo)
                    .font(.title3)
                    .padding()
            }
            .navigationTitle(arquivo.nome)
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Button(action: {
                        vm.fecharArquivo()
                    }, label: {
                        Image(systemName: "chevron.left")
                    })
                }
            }
        }
    }
}

#Preview {
    ArquivoConteudoView(arquivo: Arquivo(nome: "teste.pdf", conteudo: "Esse arquivo teste serve para eu testar arquivos!"))
        .environmentObject(ViewModel())
}
