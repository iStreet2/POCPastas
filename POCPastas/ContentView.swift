//
//  ContentView.swift
//  POCPastas
//
//  Created by Gabriel Vicentin Negro on 30/07/24.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var vm: ViewModel
    
    //CoreData
    @Environment(\.managedObjectContext) var context //Contexto, DataController
    @ObservedObject var myDataController: MyDataController
    @FetchRequest(sortDescriptors: []) var arquivos: FetchedResults<ArquivoPDF>
    
    
    init(context: NSManagedObjectContext) {
        self.myDataController = MyDataController(context: context)
    }
    
    
    var body: some View {
        
        ZStack {
            
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
                //.frame(height: 20)
                
                
                //Se houver uma pasta aberta
                if let pastaAberta = vm.pastaAberta {
                    PastaConteudoView(pasta: pastaAberta, context: context)
                }
                
                //Se houver um arquivo aberto
                if let arquivoAberto = vm.arquivoAberto {
                    ArquivoConteudoView(arquivo: arquivoAberto)
                }
            }
        }
    }
}

#Preview {
    ContentView(context: DataController().container.viewContext)
        .environmentObject(ViewModel())
}
