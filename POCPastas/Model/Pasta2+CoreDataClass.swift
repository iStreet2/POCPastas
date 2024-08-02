//
//  Pasta2+CoreDataClass.swift
//  POCPastas
//
//  Created by Gabriel Vicentin Negro on 02/08/24.
//
//

import Foundation
import CoreData

@objc(Pasta2)
public class Pasta2: NSManagedObject {

}

extension Pasta2 {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pasta2> {
        return NSFetchRequest<Pasta2>(entityName: "Pasta2")
    }

    @NSManaged public var id: String
    @NSManaged public var nome: String
    @NSManaged public var pastas: NSSet?
    @NSManaged public var arquivosPDF: NSSet?
    @NSManaged public var parentPasta: Pasta2?
}

extension Pasta2: Identifiable {
}

//MARK: Gerar acessores para pastas
extension Pasta2 {

    @objc(addPastasObject:)
    @NSManaged public func addToPastas(_ value: Pasta2)

    @objc(removePastasObject:)
    @NSManaged public func removeFromPastas(_ value: Pasta2)

    @objc(addPastas:)
    @NSManaged public func addToPastas(_ values: NSSet)

    @objc(removePastas:)
    @NSManaged public func removeFromPastas(_ values: NSSet)

}

// MARK: Gerar acessores para arquivosPDF
extension Pasta2 {

    @objc(addArquivosPDFObject:)
    @NSManaged public func addToArquivosPDF(_ value: ArquivoPDF)

    @objc(removeArquivosPDFObject:)
    @NSManaged public func removeFromArquivosPDF(_ value: ArquivoPDF)

    @objc(addArquivosPDF:)
    @NSManaged public func addToArquivosPDF(_ values: NSSet)

    @objc(removeArquivosPDF:)
    @NSManaged public func removeFromArquivosPDF(_ values: NSSet)

}
