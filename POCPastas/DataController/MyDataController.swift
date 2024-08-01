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
    }
    
    func savePDF(nome: String, conteudo: Data) {
        let novoPDF = ArquivoPDF(context: context)
        novoPDF.id = UUID()
        novoPDF.nome = nome
        novoPDF.conteudo = conteudo
        
        saveContext()
    }
    
    func saveContext() {
        do{
            try context.save()
        } catch{
            print("Não foi possível salvar os dados")
        }
    }
    
}
