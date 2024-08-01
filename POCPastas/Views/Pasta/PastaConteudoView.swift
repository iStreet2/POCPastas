//
//  PastaIconeView.swift
//  POCPastas
//
//  Created by Gabriel Vicentin Negro on 30/07/24.
//

import SwiftUI
import PDFKit
import UniformTypeIdentifiers


struct PastaConteudoView: View {
    
    @EnvironmentObject var vm: ViewModel
    
    @State var selecionado = false
    @State var arquivoSelecionado: ArquivoPDF?
    @State var showPDF = false

    
    
    //CoreData
    @Environment(\.managedObjectContext) var context //Contexto, DataController
    @ObservedObject var myDataController: MyDataController
    @FetchRequest(sortDescriptors: []) var arquivos: FetchedResults<ArquivoPDF>
    
    
    init(pasta: Pasta, context: NSManagedObjectContext) {
        self.pasta = pasta
        self.myDataController = MyDataController(context: context)
    }
    
    var pasta: Pasta
    
    let columns = [
        GridItem(.flexible(minimum: 90, maximum: 300)),
        GridItem(.flexible(minimum: 90, maximum: 300)),
        GridItem(.flexible(minimum: 90, maximum: 300)),
        GridItem(.flexible(minimum: 90, maximum: 300)),
        
    ]
    
    let spacing: CGFloat = 20
    let itemWidth: CGFloat = 100
    
    var body: some View {
        GeometryReader { geometry in
            let columns = Int(geometry.size.width / (itemWidth + spacing))
            let gridItems = Array(repeating: GridItem(.flexible(), spacing: spacing), count: max(columns, 1))
            
            NavigationStack {
                ScrollView {
                    VStack{
                        LazyVGrid(columns: gridItems, spacing: spacing) {
                            
                            //Se houver alguma pasta
                            if let pastas = pasta.pastas {
                                ForEach(pastas) { pasta in
                                    PastaIconeView(pasta: pasta)
                                        .onTapGesture(count: 2) {
                                            vm.abrirPasta(pasta: pasta)
                                        }
                                }
                            }
                            
                            //Se houver algum arquivo
                            if let arquivos = pasta.arquivos {
                                ForEach(arquivos) { arquivo in
                                    ArquivoIconeView(arquivo: arquivo)
                                        .onTapGesture(count: 2) {
                                            vm.abrirArquivo(arquivo: arquivo)
                                        }
                                }
                            }
                            
                            ForEach(arquivos) { arquivo in
                                Button(action: {
                                    arquivoSelecionado = arquivo
                                    showPDF.toggle()
                                }) {
                                    Text(arquivo.nome!)
                                }
                            }
                        }
                        .padding()
                    }
                    
                    //Se não houver nenhum arquivo ou pasta
                    if pasta.pastas == nil && pasta.arquivos == nil {
                        Text("Pasta vazia!")
                            .font(.title)
                    }
                }
                .sheet(isPresented: $showPDF, content: {
                    ShowPDFView(arquivoSelecionado: $arquivoSelecionado)
                })
                .navigationTitle(pasta.nome)
                .toolbar {
                    
                    ToolbarItem(placement: .navigation) {
                        
                        Button(action: {
                            vm.fecharPasta()
                        }, label: {
                            Image(systemName: "chevron.left")
                        })
                        .disabled(pasta.id == "0")
                        
                    }
                    
                    ToolbarItem(placement: .primaryAction) {
                        Menu {
                            Button(action: {
                                
                            }, label: {
                                Text("Nova Pasta")
                            })
                            
                            Button(action: {
                                importPDF()
                            }, label: {
                                Text("Importar Arquivo")
                            })
                        }
                    label: {
                        Image(systemName: "plus")
                    }
                    }
                }
            }
        }
    }
    
    //Função para importar o pdf e salvar no CoreData
    func importPDF() {
        let openPanel = NSOpenPanel()
        openPanel.allowedContentTypes = [UTType.pdf]
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = false
        
        openPanel.begin { response in
            if response == .OK, let url = openPanel.url {
                print("Selected URL: \(url)") // Adicionado para depuração
                do {
                    let data = try Data(contentsOf: url)
                    let nome = url.lastPathComponent
                    
                    //Savo no CoreData o PDF aberto!
                    myDataController.savePDF(nome: nome, conteudo: data)
                    
                } catch {
                    print("Failed to load data from URL: \(error.localizedDescription)")
                }
            }
        }
    }
    
}

#Preview {
    PastaConteudoView(pasta: Pasta(nome: "Testes", pastas: Pastas.exemplos(), arquivos: Arquivos.exemplos()), context: DataController().container.viewContext)
        .environmentObject(ViewModel())
}
