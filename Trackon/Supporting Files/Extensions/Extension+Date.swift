//
//  Extension+Date.swift
//  Trackon
//
//  Created by Andriy Yezerskiy on 15/03/2020.
//  Copyright © 2020 Andriy Yezerskiy. All rights reserved.
//

import Foundation

extension Date {
    func asString(with format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: self)
    }
    
    var zeroSeconds: Date {
        get {
            let calendar = Calendar.current
            let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: self)
            return calendar.date(from: dateComponents) ?? self
        }
    }
}
