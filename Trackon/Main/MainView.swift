//
//  MainView.swift
//  Trackon
//
//  Created by Andriy Yezerskiy on 14/03/2020.
//  Copyright © 2020 Andriy Yezerskiy. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection){
            TodayView()
                .tabItem {
                    VStack {
                        Image(systemName: "clock")
                        Text("Today")
                    }
            }
            .tag(0)
            OverviewView()
                .tabItem {
                    VStack {
                        Image(systemName: "calendar")
                        Text("Overview")
                    }
            }
            .tag(1)
            ProjectsView()
                .tabItem {
                    VStack {
                        Image(systemName: "folder")
                        Text("Projects")
                    }
            }
            .tag(2)
            SettingsView()
                .tabItem {
                    VStack {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
            }
            .tag(3)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        // Declare CoreData Context to avoid live preview crashes
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return MainView().environment(\.managedObjectContext, context)
    }
}
