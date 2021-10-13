//
//  UserCoreData+CoreDataProperties.swift
//  14l_ArturDokhno
//
//  Created by Артур Дохно on 10.10.2021.
//
//

import Foundation
import CoreData


extension UserCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserCoreData> {
        return NSFetchRequest<UserCoreData>(entityName: "UserCoreData")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var password: String?

}
