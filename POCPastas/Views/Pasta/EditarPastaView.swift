//
//  RenomearPasta.swift
//  POCPastas
//
//  Created by Gabriel Vicentin Negro on 08/08/24.
//

import SwiftUI
import CoreData

struct EditarPastaView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State var nome: String = ""
    @Binding var pasta: Pasta2?
    
    //CoreData
    @Environment(\.managedObjectContext) var context //Contexto, DataController
    @ObservedObject var myDataController: MyDataController
    
    init(pasta: Binding<Pasta2?>, context: NSManagedObjectContext) {
        self._pasta = pasta
        self.myDataController = MyDataController(context: context)
    }
    
    var body: some View {
        VStack {
            TextField(pasta?.nome ?? "Novo nome", text: $nome)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom)
                .padding()
            Button {
                withAnimation() {
                    myDataController.editPasta(pasta: pasta!, nome: nome)
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

