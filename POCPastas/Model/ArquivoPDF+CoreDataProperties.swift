//
//  ArquivoPDF+CoreDataProperties.swift
//  POCPastas
//
//  Created by Gabriel Vicentin Negro on 08/08/24.
//
//

import Foundation
import CoreData


extension ArquivoPDF {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArquivoPDF> {
        return NSFetchRequest<ArquivoPDF>(entityName: "ArquivoPDF")
    }

    @NSManaged public var conteudo: Data?
    @NSManaged public var id: String
    @NSManaged public var nome: String
    @NSManaged public var pasta: Pasta2?

}

extension ArquivoPDF : Identifiable {

}
