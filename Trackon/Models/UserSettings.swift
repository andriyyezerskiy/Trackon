//
//  UserSettings.swift
//  Trackon
//
//  Created by Andriy Yezerskiy on 21/03/2020.
//  Copyright © 2020 Andriy Yezerskiy. All rights reserved.
//

import Combine
import SwiftUI

final class UserSettings: ObservableObject {
    
    private enum Keys {
        static let dailyGoal = "dailyGoal"
    }
    
    private let cancellable: Cancellable
    private let defaults: UserDefaults
    
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        
        defaults.register(defaults: [
            Keys.dailyGoal: true
        ])
        
        cancellable = NotificationCenter.default
            .publisher(for: UserDefaults.didChangeNotification)
            .map { _ in () }
            .subscribe(objectWillChange)
    }
    
    var dailyGoal: Float {
        set { defaults.set(newValue, forKey: Keys.dailyGoal) }
        get { defaults.float(forKey: Keys.dailyGoal) }
    }
}
