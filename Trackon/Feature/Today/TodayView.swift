//
//  TodayView.swift
//  Trackon
//
//  Created by Andriy Yezerskiy on 14/03/2020.
//  Copyright © 2020 Andriy Yezerskiy. All rights reserved.
//

import SwiftUI

struct TodayView: View {
    
    var today: Date = Date()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello, World!")
            }
            .navigationBarTitle(Text(format(date: today)), displayMode: .large)
            .navigationBarItems(trailing: Button(action: {
                
            }) {
                Image(systemName: "plus")
            })
        }
    }
    
    func format(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        
        return dateFormatter.string(from: date)
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
    }
}
