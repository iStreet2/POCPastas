//
//  PDFView.swift
//  POCPastas
//
//  Created by Gabriel Vicentin Negro on 01/08/24.
//

import SwiftUI
import PDFKit

struct ShowPDFView: View {
    
    @Binding var arquivoSelecionado: ArquivoPDF?
    
    var body: some View {
        
        if let arquivoSelecionado = arquivoSelecionado {
            if let conteudo = arquivoSelecionado.conteudo {
                if let documentoPDF = PDFDocument(data: conteudo) {
                    PDFKitView(pdfDocument: documentoPDF)
                        .frame(minWidth: 300, minHeight: 400)
                } else {
                    Text("Erro ao criar o documento PDF")
                }
            } else {
                Text("Erro ao ler o conteudo")
            }
        } else {
            Text("Erro ao selecionar arquivo")
        }
    }
}
