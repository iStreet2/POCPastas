//
//  ContentView.swift
//  POCPastas
//
//  Created by Gabriel Vicentin Negro on 30/07/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    //MARK: ViewModel
    @EnvironmentObject var vm: ViewModel
    
    //MARK: CoreData
    @Environment(\.managedObjectContext) var context //Contexto, DataController
    @ObservedObject var myDataController: MyDataController
    @FetchRequest(sortDescriptors: []) var arquivos: FetchedResults<ArquivoPDF>
    @FetchRequest(sortDescriptors: []) var pastas: FetchedResults<Pasta2>
    
    
    init(context: NSManagedObjectContext) {
        self.myDataController = MyDataController(context: context)
    }
    
    
    var body: some View {
        VStack{
            ScrollView(.horizontal, showsIndicators: false) {
                HStack{
                    ForEach(vm.caminho.getItens()) { item in
                        HStack {
                            Text("\(item.nome)")
                            Image(systemName: "chevron.right")
                        }
                    }
                }
            }
            .padding()
            
            //Se houver uma pasta aberta
            if let pastaAberta = vm.pastaAberta {
                PastaConteudoView(pasta: pastaAberta, context: context)
            }
            
            Button {
                self.myDataController.apagarTodosOsItens()
            } label: {
                Text("Apagar tudo!")
            }
        }
        
        .onAppear {
            
            
            
            if pastas[0].id == "raiz" {
                let pastaRaiz = pastas[0]
                vm.pastaAberta = pastaRaiz
                vm.caminho.push(pastaRaiz)
                
            }
        }
    }
}

//#Preview {
//    ContentView(context: DataController().container.viewContext)
//        .environmentObject(ViewModel())
//}
