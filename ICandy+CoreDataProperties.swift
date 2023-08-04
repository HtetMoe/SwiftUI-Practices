//
//  ICandy+CoreDataProperties.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 17/07/2023.
//
//

import Foundation
import CoreData


extension ICandy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ICandy> {
        return NSFetchRequest<ICandy>(entityName: "ICandy")
    }

    @NSManaged public var name: String?
    @NSManaged public var origin: ICountry?

    public var wrappedName: String {
        name ?? "Unknown Candy"
    }
}

extension ICandy : Identifiable {

}
