//
//  Extension+TimeInterval.swift
//  Trackon
//
//  Created by Andriy Yezerskiy on 15/03/2020.
//  Copyright © 2020 Andriy Yezerskiy. All rights reserved.
//

import Foundation

extension TimeInterval {
    var userReadable: String {
        get {
            let formatter = DateComponentsFormatter()
            formatter.zeroFormattingBehavior = .pad
            formatter.allowedUnits = [.hour, .minute]
        
            return formatter.string(from: self) ?? ""
        }
    }
}
