//
//  Game+CoreDataProperties.swift
//  CoreDataTitleAndWorth
//
//  Created by Field Employee on 10/30/21.
//
//

import Foundation
import CoreData


extension Game {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Game> {
        return NSFetchRequest<Game>(entityName: "Game")
    }

    @NSManaged public var title: String
    @NSManaged public var worth: String

}

extension Game : Identifiable {

}
