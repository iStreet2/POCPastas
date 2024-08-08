//
//  PastaIconeView.swift
//  POCPastas
//
//  Created by Gabriel Vicentin Negro on 30/07/24.
//

import SwiftUI

struct PastaIconeView: View {
    
    //var pasta: Pasta
    @ObservedObject var pasta: Pasta2
    
    var body: some View {
        VStack{
            Image(systemName: "folder")
                .font(.system(size: 70))
            //Text(pasta.nome)
            Text(pasta.nome)
                .lineLimit(2)
        }
    }
}

//#Preview {
//    PastaIconeView(pasta: Pasta(nome: "Testes"))
//}
