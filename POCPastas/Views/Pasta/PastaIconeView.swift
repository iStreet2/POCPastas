//
//  PastaIconeView.swift
//  POCPastas
//
//  Created by Gabriel Vicentin Negro on 30/07/24.
//

import SwiftUI

struct PastaIconeView: View {
    
    var pasta: Pasta
    
    var body: some View {
        VStack{
            Image(systemName: "folder")
                .font(.system(size: 70))
            Text(pasta.nome)
        }
    }
}

#Preview {
    PastaIconeView(pasta: Pasta(nome: "Testes"))
}
