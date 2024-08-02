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
    @State var criarPasta = false

    @Environment(\.managedObjectContext) var context //Contexto, DataController
    @ObservedObject var myDataController: MyDataController
    
    @FetchRequest var arquivos: FetchedResults<ArquivoPDF>
    @FetchRequest var pastas: FetchedResults<Pasta2>
    
    init(pasta: Pasta2 /*Pasta*/, context: NSManagedObjectContext) {
        self.pasta = pasta
        self.myDataController = MyDataController(context: context)
        _arquivos = FetchRequest<ArquivoPDF>(
            sortDescriptors: [],
            predicate: NSPredicate(format: "pasta == %@", pasta)
        )
        _pastas = FetchRequest<Pasta2>(
            sortDescriptors: [],
            predicate: NSPredicate(format: "parentPasta == %@", pasta)
        )
    }
    
    var pasta: Pasta2
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
                    VStack {
                        LazyVGrid(columns: gridItems, spacing: spacing) {
                            ForEach(pastas, id: \.self) { subpasta in
                                PastaIconeView(pasta: subpasta)
                                    .onTapGesture(count: 2) {
                                        vm.abrirPasta(pasta: subpasta)
                                    }
                            }
                            
                            ForEach(arquivos, id: \.self) { arquivo in
                                ArquivoIconeView(arquivoPDF: arquivo)
                                    .onTapGesture(count: 2) {
                                        arquivoSelecionado = arquivo
                                        showPDF.toggle()
                                    }
                            }
                        }
                        .padding()
                    }
                    
                    if pastas.isEmpty && arquivos.isEmpty {
                        Text("Pasta vazia!")
                            .font(.title)
                    }
                }
                .sheet(isPresented: $showPDF, content: {
                    ShowPDFView(arquivoSelecionado: $arquivoSelecionado)
                })
                .sheet(isPresented: $criarPasta, content: {
                    CriarPastaView(pastaPai: self.pasta, context: context)
                })
                .navigationTitle(pasta.nome)
                .toolbar {
                    // Botão de voltar pasta!
                    ToolbarItem(placement: .navigation) {
                        Button(action: {
                            vm.fecharPasta()
                        }, label: {
                            Image(systemName: "chevron.left")
                        })
                        .disabled(pasta.id == "raiz")
                    }
                    // Botão para criar nova pasta ou importar arquivo
                    ToolbarItem(placement: .primaryAction) {
                        Menu {
                            Button(action: {
                                criarPasta.toggle()
                            }, label: {
                                Text("Nova Pasta")
                            })
                            
                            Button(action: {
                                importPDF()
                            }, label: {
                                Text("Importar Arquivo")
                            })
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
        }
    }
    
    func importPDF() {
        let openPanel = NSOpenPanel()
        openPanel.allowedContentTypes = [UTType.pdf]
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = false
        
        openPanel.begin { response in
            if response == .OK, let url = openPanel.url {
                do {
                    let data = try Data(contentsOf: url)
                    let nome = url.lastPathComponent
                    
                    // Salvo no CoreData o PDF aberto!
                    myDataController.savePDF(pasta: self.pasta, nome: nome, conteudo: data)
                } catch {
                    print("Failed to load data from URL: \(error.localizedDescription)")
                }
            }
        }
    }
}

//#Preview {
//    PastaConteudoView(pasta: Pasta(nome: "Testes", pastas: Pastas.exemplos(), arquivos: Arquivos.exemplos()), context: DataController().container.viewContext)
//        .environmentObject(ViewModel())
//}
