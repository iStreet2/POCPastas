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
        container.loadPersistentStores{ descricao, erro in
            if let erro = erro{
                print("Erro ao pegar os dados \(erro.localizedDescription)")
            }
        }
    }
}
