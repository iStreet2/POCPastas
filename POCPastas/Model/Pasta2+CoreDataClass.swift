//
//  Pasta2+CoreDataClass.swift
//  POCPastas
//
//  Created by Gabriel Vicentin Negro on 01/08/24.
//
//

import Foundation
import CoreData

@objc(Pasta2)
public class Pasta2: NSManagedObject, Identifiable {
    
    @NSManaged public var id: String
    @NSManaged public var nome: String
    @NSManaged public var pastas: Set<Pasta2>?
    @NSManaged public var arquivosPDF: Set<ArquivoPDF>?
    
    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
        self.id = UUID().uuidString
    }
    
    init(context: NSManagedObjectContext, id: String = UUID().uuidString, nome: String, pastas: Set<Pasta2>? = nil, arquivosPDF: Set<ArquivoPDF>? = nil) {
        let entity = NSEntityDescription.entity(forEntityName: "Pasta2", in: context)!
        super.init(entity: entity, insertInto: context)
        self.id = id
        self.nome = nome
        self.pastas = pastas
        self.arquivosPDF = arquivosPDF
    }
    
    public static func == (lhs: Pasta2, rhs: Pasta2) -> Bool {
        return lhs.id == rhs.id
    }
}
