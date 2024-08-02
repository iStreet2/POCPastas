//
//  CriarPastaView.swift
//  POCPastas
//
//  Created by Gabriel Vicentin Negro on 02/08/24.
//

import SwiftUI

struct CriarPastaView: View {
    
    @State var nome: String = ""
    var pastaPai: Pasta2
    @Environment(\.dismiss) private var dismiss
    
    //CoreData
    @Environment(\.managedObjectContext) var context //Contexto, DataController
    @ObservedObject var myDataController: MyDataController
    
    
    init(pastaPai: Pasta2, context: NSManagedObjectContext) {
        self.pastaPai = pastaPai
        self.myDataController = MyDataController(context: context)
    }
    
    var body: some View {
        NavigationStack {
            VStack{
                TextField("Nome", text: $nome)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                Button(action: {
                    myDataController.addPasta(pasta: pastaPai, nome: nome)
                    dismiss()
                }, label: {
                    Text("Criar")
                })
            }
            .padding()
            .navigationTitle("Criar Pasta")
            .frame(minWidth: 400, minHeight: 100)
        }
    }
}

#Preview {
    CriarPastaView(pastaPai: Pasta2(context: DataController().container.viewContext),context: DataController().container.viewContext)
        .environmentObject(ViewModel())
}
