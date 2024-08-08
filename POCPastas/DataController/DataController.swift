//
//  DataController.swift
//  POCPastas
//
//  Created by Gabriel Vicentin Negro on 01/08/24.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    
    let container = NSPersistentContainer(name: "Model")
    
    
    init() {
        
//        if let storeURL = container.persistentStoreDescriptions.first?.url {
//            do {
//                try container.persistentStoreCoordinator.destroyPersistentStore(at: storeURL, ofType: NSSQLiteStoreType, options: nil)
//                try container.persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
//            } catch {
//                fatalError("Failed to rebuild persistent store: \(error)")
//            }
//        }
        
        container.loadPersistentStores{ descricao, erro in
            if let erro = erro{
                print("Erro ao pegar os dados \(erro.localizedDescription)")
            }
        }
    }
}
