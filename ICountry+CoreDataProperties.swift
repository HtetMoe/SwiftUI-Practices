//
//  ICountry+CoreDataProperties.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 17/07/2023.
//
//

import Foundation
import CoreData


extension ICountry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ICountry> {
        return NSFetchRequest<ICountry>(entityName: "ICountry")
    }

    @NSManaged public var shortName: String?
    @NSManaged public var fullName: String?
    @NSManaged public var candy: NSSet?

    public var wrappedShortName: String {
        shortName ?? "Unknown Country"
    }

    public var wrappedFullName: String {
        fullName ?? "Unknown Country"
    }
    
    //candies
    public var candyArray: [ICandy] {
        let set = candy as? Set<ICandy> ?? []
        
        //sorting
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
}

// MARK: Generated accessors for candy
extension ICountry {

    @objc(addCandyObject:)
    @NSManaged public func addToCandy(_ value: ICandy)

    @objc(removeCandyObject:)
    @NSManaged public func removeFromCandy(_ value: ICandy)

    @objc(addCandy:)
    @NSManaged public func addToCandy(_ values: NSSet)

    @objc(removeCandy:)
    @NSManaged public func removeFromCandy(_ values: NSSet)

}

extension ICountry : Identifiable {

}
