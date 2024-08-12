//
//  EditarArquivoView.swift
//  POCPastas
//
//  Created by Gabriel Vicentin Negro on 08/08/24.
//

import SwiftUI
import CoreData 

struct EditarArquivoView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State var nome: String = ""
    @Binding var arquivo: ArquivoPDF?
    
    //CoreData
    @Environment(\.managedObjectContext) var context //Contexto, DataController
    @ObservedObject var myDataController: MyDataController
    
    init(arquivo: Binding<ArquivoPDF?>, context: NSManagedObjectContext) {
        self._arquivo = arquivo
        self.myDataController = MyDataController(context: context)
    }
    
    var body: some View {
        VStack {
            TextField(arquivo?.nome ?? "Novo nome", text: $nome)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom)
                .padding()
            Button {
                withAnimation() {
                    myDataController.editPDF(arquivoPDF: arquivo!, nome: nome)
                }
                dismiss()
            } label: {
                Text("Salvar")
            }
        }
        .padding()
        .padding(.horizontal, 100)
    }
}

