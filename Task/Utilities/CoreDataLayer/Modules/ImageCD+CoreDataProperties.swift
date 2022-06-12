//
//  ImageCD+CoreDataProperties.swift
//  Task
//
//  Created by John Doe on 2022-06-10.
//
//

import Foundation
import CoreData


extension ImageCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageCD> {
        return NSFetchRequest<ImageCD>(entityName: "ImageCD")
    }

    @NSManaged public var url: String?
    @NSManaged public var width: Int64
    @NSManaged public var height: Int64

}

extension ImageCD : Identifiable {

}
