//
//  ArquivoPDF+CoreDataClass.swift
//  POCPastas
//
//  Created by Gabriel Vicentin Negro on 02/08/24.
//
//

import Foundation
import CoreData

@objc(ArquivoPDF)
public class ArquivoPDF: NSManagedObject {
    
}

extension ArquivoPDF {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArquivoPDF> {
        return NSFetchRequest<ArquivoPDF>(entityName: "ArquivoPDF")
    }

    @NSManaged public var id: UUID
    @NSManaged public var nome: String
    @NSManaged public var conteudo: Data?
    @NSManaged public var pasta: Pasta2?
}

extension ArquivoPDF: Identifiable {
}
