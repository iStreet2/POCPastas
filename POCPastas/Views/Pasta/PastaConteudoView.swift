//
//  PastaIconeView.swift
//  POCPastas
//
//  Created by Gabriel Vicentin Negro on 30/07/24.
//

import SwiftUI
import PDFKit
import UniformTypeIdentifiers
import CoreData

struct PastaConteudoView: View {
    
    //MARK: ViewModel
    @EnvironmentObject var vm: ViewModel
    
    //MARK: Variáveis de estado
    @ObservedObject var pasta: Pasta2
    
    @State var selecionado = false
    @State var arquivoSelecionado: ArquivoPDF?
    @State var showPDF = false
    @State var criarPasta = false
    
    @State var renomearArquivo = false
    @State var arquivoASerRenomeado: ArquivoPDF?
    
    @State var renomearPasta = false
    @State var pastaASerRenomeada: Pasta2?
    
    @State private var pastaOffsets: [String: CGSize] = [:]
    @State private var pastaFrames: [String: CGRect] = [:]
    
    @State private var arquivoOffsets: [String: CGSize] = [:]
    @State private var arquivoFrames: [String: CGRect] = [:]
    
    //MARK: CoreData
    @Environment(\.managedObjectContext) var context //Contexto, DataController
    @ObservedObject var myDataController: MyDataController
    
    @FetchRequest var arquivos: FetchedResults<ArquivoPDF>
    @FetchRequest var pastas: FetchedResults<Pasta2>
    
    init(pasta: Pasta2, context: NSManagedObjectContext) {
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
                                GeometryReader { geometry in
                                    PastaIconeView(pasta: subpasta)
                                        .offset(x: pastaOffsets[subpasta.id]?.width ?? 0, y: pastaOffsets[subpasta.id]?.height ?? 0)
                                        .gesture(
                                            DragGesture()
                                                .onChanged { gesture in
                                                    pastaOffsets[subpasta.id] = gesture.translation
                                                    
                                                    // Atualizar a posição da pasta durante o arrasto
                                                    let frame = geometry.frame(in: .global).offsetBy(dx: gesture.translation.width, dy: gesture.translation.height)
                                                    pastaFrames[subpasta.id] = frame
                                                    
                                                    
                                                }
                                                .onEnded { _ in
                                                    
                                                    var collisionDetected = false
                                                    var pastaDestino: Pasta2?
                                                    
                                                    if let movingPastaFrame = pastaFrames[subpasta.id] {
                                                        for (id, frame) in pastaFrames {
                                                            if id != subpasta.id, frame.intersects(movingPastaFrame) {
                                                                // Lógica a ser executada quando houver colisão
                                                                print("Pasta \(subpasta.nome) colidiu com a pasta de id \(id)")
                                                                
                                                                // Encontrar a pasta destino
                                                                if let destino = pastas.first(where: { $0.id == id }) {
                                                                    pastaDestino = destino
                                                                } else {
                                                                    print("nao encontrou a pasta destino")
                                                                }
                                                                
                                                                
                                                                collisionDetected = true
                                                                break
                                                            }
                                                        }
                                                    }
                                                    
                                                    if collisionDetected, let destino = pastaDestino {
                                                        withAnimation(.easeIn) {
                                                            myDataController.movePasta(pastaPai: pasta, pastaMovendo: subpasta, pastaDestino: destino)
                                                            pastaOffsets[subpasta.id] = .zero
                                                        }
                                                    } else {
                                                        withAnimation(.bouncy) {
                                                            pastaOffsets[subpasta.id] = .zero
                                                        }
                                                    }
                                                }
                                            
                                        )
                                        .onAppear {
                                            let frame = geometry.frame(in: .global)
                                            pastaFrames[subpasta.id] = frame
                                        }
                                        .onChange(of: geometry.frame(in: .global)) { newFrame in
                                            pastaFrames[subpasta.id] = newFrame
                                        }
                                    
                                    // Botão direito
                                        .contextMenu {
                                            Button(action: {
                                                vm.abrirPasta(pasta: subpasta)
                                            }) {
                                                Text("Abrir Pasta")
                                                Image(systemName: "folder")
                                            }
                                            Button(action: {
                                                // Ação para renomear a pasta
                                                pastaASerRenomeada = subpasta
                                                renomearPasta.toggle()
                                            }) {
                                                Text("Renomear")
                                                Image(systemName: "pencil")
                                            }
                                            Button(action: {
                                                // Ação para excluir a pasta
                                                withAnimation(.easeIn) {
                                                    myDataController.deletePasta(pastaPai: pasta, pasta: subpasta)
                                                }
                                            }) {
                                                Text("Excluir")
                                                Image(systemName: "trash")
                                            }
                                        }
                                    
                                    // Abrir a pasta
                                        .onTapGesture(count: 2) {
                                            vm.abrirPasta(pasta: subpasta)
                                        }
                                    
                                }
                            }
                        
                            ForEach(arquivos, id: \.self) { arquivo in
                                ArquivoIconeView(arquivoPDF: arquivo)
                                    .offset(x: arquivoOffsets[arquivo.id]?.width ?? 0, y: arquivoOffsets[arquivo.id]?.height ?? 0)
                                    .gesture(
                                        DragGesture()
                                            .onChanged { gesture in
                                                arquivoOffsets[arquivo.id] = gesture.translation
                                                
                                                // Atualizar a posição da pasta durante o arrasto
                                                let frame = geometry.frame(in: .global).offsetBy(dx: gesture.translation.width, dy: gesture.translation.height)
                                                arquivoFrames[arquivo.id] = frame
                                                
                                                
                                            }
                                            .onEnded { _ in
                                                
                                                var collisionDetected = false
                                                var pastaDestino: Pasta2?
                                                
                                                if let movingArquivoFrame = arquivoFrames[arquivo.id] {
                                                    for (id, frame) in pastaFrames {
                                                        if id != arquivo.id, frame.intersects(movingArquivoFrame) {
                                                            // Lógica a ser executada quando houver colisão
                                                            print("Arquivo \(arquivo.nome) colidiu com a pasta de id \(id)")
                                                            
                                                            // Encontrar a pasta destino
                                                            if let destino = pastas.first(where: { $0.id == id }) {
                                                                pastaDestino = destino
                                                            } else {
                                                                print("nao encontrou a pasta destino")
                                                            }
                                                            collisionDetected = true
                                                            break
                                                        }
                                                    }
                                                }
                                                
                                                if collisionDetected, let destino = pastaDestino {
                                                    withAnimation(.easeIn) {
                                                        myDataController.moveArquivo(pastaPai: pasta, arquivoMovendo: arquivo, pastaDestino: destino)
                                                        arquivoOffsets[arquivo.id] = .zero
                                                    }
                                                } else {
                                                    withAnimation(.bouncy) {
                                                        arquivoOffsets[arquivo.id] = .zero
                                                    }
                                                }
                                            }
                                        
                                    )
                                    .onAppear {
                                        let frame = geometry.frame(in: .global)
                                        arquivoFrames[arquivo.id] = frame
                                    }
                                    .onChange(of: geometry.frame(in: .global)) { newFrame in
                                        arquivoFrames[arquivo.id] = newFrame
                                    }
                                
                                    
                                    
                                    .contextMenu {
                                        Button(action: {
                                            // Ação para abrir o arquivo
                                            arquivoSelecionado = arquivo
                                            showPDF.toggle()
                                        }) {
                                            Text("Abrir Arquivo")
                                            Image(systemName: "doc.text")
                                        }
                                        
                                        Button(action: {
                                            // Ação para renomear o arquivo
                                            arquivoASerRenomeado = arquivo
                                            renomearArquivo.toggle()
                                            
                                        }) {
                                            Text("Renomear")
                                            Image(systemName: "pencil")
                                        }
                                        
                                        Button(action: {
                                            // Ação para excluir o arquivo
                                            withAnimation() {
                                                myDataController.deletePDF(pastaPai: pasta, arquivoPDF: arquivo)
                                            }
                                        }) {
                                            Text("Excluir")
                                            Image(systemName: "trash")
                                        }
                                    }
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
                .sheet(isPresented: $renomearPasta, content: {
                    EditarPastaView(pasta: $pastaASerRenomeada, context: context)
                })
                .sheet(isPresented: $renomearArquivo, content: {
                    EditarArquivoView(arquivo: $arquivoASerRenomeado, context: context)
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
            .onChange(of: pasta) { _ in
                atualizarFrames()
            }
        }
    }
    
    func atualizarFrames() {
        pastaOffsets.removeAll()
        pastaFrames.removeAll()
        
        arquivoOffsets.removeAll()
        arquivoFrames.removeAll()
        
        DispatchQueue.main.async {
            for pasta in pastas {
                pastaOffsets[pasta.id] = .zero
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    if let frame = pastaFrames[pasta.id] {
                        pastaFrames[pasta.id] = frame
                    }
                }
            }
            for arquivo in arquivos {
                arquivoOffsets[arquivo.id] = .zero
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    if let frame = arquivoFrames[arquivo.id] {
                        arquivoFrames[arquivo.id] = frame
                    }
                }
            }
        }
    }
    
    func importPDF() {
//        let openPanel = NSOpenPanel()
//        openPanel.allowedContentTypes = [UTType.pdf]
//        openPanel.allowsMultipleSelection = false
//        openPanel.canChooseDirectories = false
//        
//        openPanel.begin { response in
//            if response == .OK, let url = openPanel.url {
//                do {
//                    let data = try Data(contentsOf: url)
//                    let nome = url.lastPathComponent
//                    print(url)
//                    
//                    // Salvo no CoreData o PDF aberto!
//                    myDataController.savePDF(pasta: self.pasta, nome: nome, conteudo: data)
//                } catch {
//                    print("Failed to load data from URL: \(error.localizedDescription)")
//                }
//            }
//        }
    }


}

