//
//  ProductCD+CoreDataProperties.swift
//  Task
//
//  Created by John Doe on 2022-06-10.
//
//

import Foundation
import CoreData


extension ProductCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductCD> {
        return NSFetchRequest<ProductCD>(entityName: "ProductCD")
    }

    @NSManaged public var id: Int64
    @NSManaged public var productDescription: String?
    @NSManaged public var price: Int64
    @NSManaged public var image: ImageCD?

}

extension ProductCD : Identifiable {

}
