//
//  TrackerItem.swift
//  Trackon
//
//  Created by Andriy Yezerskiy on 15/03/2020.
//  Copyright © 2020 Andriy Yezerskiy. All rights reserved.
//

import Foundation
import CoreData

public class TrackerItem: NSManagedObject, Identifiable {
    
    @NSManaged public var createdAt: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var project: String?
    @NSManaged public var task: String?
    @NSManaged public var timeTracked: NSNumber?
    @NSManaged public var trackerDescription: String?
    
}

extension TrackerItem {
    
    static func getAllTrackerItems() -> NSFetchRequest<TrackerItem> {
        let request: NSFetchRequest<TrackerItem> = TrackerItem.fetchRequest() as! NSFetchRequest<TrackerItem>
        let sortDescriptor: NSSortDescriptor = .init(key: "createdAt", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
}
