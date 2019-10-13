//
//  Tile+CoreDataProperties.swift
//  Cinema
//
//  Created by Alex on 3/2/19.
//  Copyright © 2019 Alex. All rights reserved.
//
//

import Foundation
import CoreData

extension Tile {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tile> {
        return NSFetchRequest<Tile>(entityName: "Tile")
    }

    @NSManaged public var voteAverage: Double
    @NSManaged public var voteCount: Int
    @NSManaged public var id: Int
    @NSManaged public var video: Bool
    @NSManaged public var title: String?
    @NSManaged public var popularity: Double
    @NSManaged public var adult: Bool
    @NSManaged public var overview: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var itemIndex: Int
    @NSManaged public var sectionIndex: Int
    @NSManaged public var category: Int
}
