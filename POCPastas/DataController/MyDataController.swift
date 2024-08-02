//
//  MyDataController.swift
//  POCPastas
//
//  Created by Gabriel Vicentin Negro on 01/08/24.
//

import Foundation
import CoreData


class MyDataController: ObservableObject {
    
    var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext){
        self.context = context
        initSettings()
    }
    
    //Se for a primeira vez que o usuário abre o app, a pasta raiz sera criada
    func initSettings(){
        let amountCoreDataItems = try? context.count(for: Pasta2.fetchRequest())
        guard amountCoreDataItems == 0 else{
            return
        }
        criarRaiz(nome: "Raiz")
        
    }
    
    func savePDF(pasta: Pasta2, nome: String, conteudo: Data) {
        let novoPDF = ArquivoPDF(context: context)
        novoPDF.id = UUID()
        novoPDF.nome = nome
        novoPDF.conteudo = conteudo
        novoPDF.pasta = pasta  // Estabelecendo a referência à pasta pai
        
        // Adiciona o novo arquivo ao conjunto de arquivos da pasta pai
        pasta.addToArquivosPDF(novoPDF)
        
        saveContext()
    }

    
    func criarRaiz(nome: String) {
        let novaPasta = Pasta2(context: context)
        novaPasta.nome = "Raiz"
        novaPasta.id = "raiz"
        saveContext()
    }
    
    //Nessa função será possível criar uma pasta dentro de outra pasta
    func addPasta(pasta: Pasta2, nome: String) {
        let novaPasta = Pasta2(context: context)
        novaPasta.id = UUID().uuidString
        novaPasta.nome = nome
        novaPasta.parentPasta = pasta  // Estabelecendo a referência à pasta pai
        
        // Adiciona a nova pasta ao conjunto de pastas da pasta pai
        pasta.addToPastas(novaPasta)
        
        saveContext()
    }
    
    func deletePDF(pastaPai: Pasta2, arquivoPDF: ArquivoPDF) {
        pastaPai.removeFromArquivosPDF(arquivoPDF)
        saveContext()
        context.delete(arquivoPDF)
        saveContext()
    }
    
    func deletePasta(pastaPai: Pasta2, pasta: Pasta2) {
        pastaPai.removeFromPastas(pasta)
        context.delete(pasta)
        saveContext()
    }
    
    func saveContext() {
        do{
            try context.save()
        } catch{
            print("Não foi possível salvar os dados")
        }
    }
    
    // Função para apagar todos os itens do Core Data
    func apagarTodosOsItens() {
        let fetchRequestPasta2: NSFetchRequest<NSFetchRequestResult> = Pasta2.fetchRequest()
        let fetchRequestArquivoPDF: NSFetchRequest<NSFetchRequestResult> = ArquivoPDF.fetchRequest()
        
        let deleteRequestPasta2 = NSBatchDeleteRequest(fetchRequest: fetchRequestPasta2)
        let deleteRequestArquivoPDF = NSBatchDeleteRequest(fetchRequest: fetchRequestArquivoPDF)
        
        do {
            try context.execute(deleteRequestPasta2)
            try context.execute(deleteRequestArquivoPDF)
            try context.save()
        } catch {
            print("Erro ao apagar itens: \(error.localizedDescription)")
        }
    }
    
}

