//
//  Pasta2+CoreDataProperties.swift
//  POCPastas
//
//  Created by Gabriel Vicentin Negro on 05/08/24.
//
//

import Foundation
import CoreData


extension Pasta2 {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pasta2> {
        return NSFetchRequest<Pasta2>(entityName: "Pasta2")
    }

    @NSManaged public var id: String?
    @NSManaged public var nome: String
    @NSManaged public var positionX: Float
    @NSManaged public var positionY: Float
    @NSManaged public var arquivosPDF: NSSet?
    @NSManaged public var parentPasta: Pasta2?
    @NSManaged public var pastas: NSSet?

}

// MARK: Generated accessors for arquivosPDF
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

// MARK: Generated accessors for pastas
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

extension Pasta2 : Identifiable {

}
