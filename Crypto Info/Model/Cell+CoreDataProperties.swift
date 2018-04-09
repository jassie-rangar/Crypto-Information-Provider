//
//  Cell+CoreDataProperties.swift
//  Crypto Info
//
//  Created by Jaskirat Singh on 08/04/18.
//  Copyright © 2018 jassie. All rights reserved.
//
//

import Foundation
import CoreData


extension Cell {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cell> {
        return NSFetchRequest<Cell>(entityName: "Cell")
    }

    @NSManaged public var currencyName: String?
    @NSManaged public var symbol: String?

    convenience init(name: String, symb: String, context: NSManagedObjectContext)
     {
         if let ent = NSEntityDescription.entity(forEntityName: "cell", in: context)
         {
             self.init(entity: ent, insertInto: context)
             self.currencyName = name
             self.symbol = symb
         }
         else
         {
            fatalError("ERROR: No Entity found!!")
         }
    }
}
