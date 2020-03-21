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
    
    static func getTodayTrackerItems() -> NSFetchRequest<TrackerItem> {
        let request: NSFetchRequest<TrackerItem> = TrackerItem.fetchRequest() as! NSFetchRequest<TrackerItem>
        let sortDescriptor: NSSortDescriptor = .init(key: "createdAt", ascending: true)
        
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.autoupdatingCurrent

        let dateFrom = calendar.startOfDay(for: Date())
        if let dateTo = calendar.date(byAdding: .day, value: 1, to: dateFrom) {
            let fromPredicate = NSPredicate(format: "%@ >= %@", dateFrom as NSDate)
            let toPredicate = NSPredicate(format: "%@ < %@", dateTo as NSDate)
            let datePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
            
            request.predicate = datePredicate
        }

        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
}
