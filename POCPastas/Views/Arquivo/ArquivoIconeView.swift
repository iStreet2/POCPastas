//
//  ArquivoÍcone.swift
//  POCPastas
//
//  Created by Gabriel Vicentin Negro on 30/07/24.
//

import SwiftUI

struct ArquivoIconeView: View {
    
    //var arquivo: Arquivo
    var arquivoPDF: ArquivoPDF
    
    var body: some View {
        VStack{
            Image(systemName: "doc")
                .font(.system(size: 70))
            //Text(arquivo.nome)
            Text(arquivoPDF.nome ?? "ArquivoSemNome")
                .lineLimit(2)
        }
    }
}

//#Preview {
//    ArquivoIconeView(arquivo: Arquivo(nome: "teste.pdf", conteudo: "Alloooouuu!!"))
//}
