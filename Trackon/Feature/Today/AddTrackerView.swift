//
//  AddTrackerView.swift
//  Trackon
//
//  Created by Andriy Yezerskiy on 15/03/2020.
//  Copyright © 2020 Andriy Yezerskiy. All rights reserved.
//

import SwiftUI
import CoreData

/*
    Known SwiftUI issue:
    
    - Multiline TextField are not working yet
 
*/

struct AddTrackerView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    
    @State var projectTitle: String = String()
    @State var task: String = String()
    @State var description: String = String()
    @State var date: Date = Date()
    @State var fromTime: Date = Date()
    @State var toTime: Date = Date()
    
    var body: some View {
        NavigationView() {
            VStack() {
                Form {
                    Section(header:
                        Text("Project")
                            .fontWeight(.semibold)
                    ) {
                        TextField("Project Title", text: $projectTitle)
                        
                        TextField("Task", text: $task)
                    }
                    
                    Section(header:
                        Text("Details")
                            .fontWeight(.semibold)
                    ) {
                        TextField("Description", text: $description)
                        
                        DatePicker(selection: $date, displayedComponents: .date) {
                            Text("Date")
                        }
                        
                        DatePicker(selection: $fromTime, displayedComponents: .hourAndMinute) {
                            Text("From")
                        }
                        
                        DatePicker(selection: $toTime, in: PartialRangeFrom($fromTime.wrappedValue), displayedComponents: .hourAndMinute) {
                            Text("To")
                        }
                    }
                }
            }
            .navigationBarTitle("New Tracker", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                },
                trailing: Button(action: {
                    let item = TrackerItem(context: self.managedObjectContext)
                    item.id = UUID()
                    item.project = self.projectTitle
                    item.task = self.task
                    item.createdAt = self.date
                    item.trackerDescription = self.description
                    item.timeTracked = NSNumber(value: self.toTime.zeroSeconds.timeIntervalSince(self.fromTime.zeroSeconds))
     
                    do {
                        try self.managedObjectContext.save()
                        self.presentationMode.wrappedValue.dismiss()
                    } catch {
                        print(error.localizedDescription)
                    }
                }) {
                    Text("Add")
                        .fontWeight(.semibold)
                }
            )
        }
    }
}

struct AddTrackerView_Previews: PreviewProvider {
    static var previews: some View {
        AddTrackerView()
    }
}
