//
//  TodayView.swift
//  Trackon
//
//  Created by Andriy Yezerskiy on 14/03/2020.
//  Copyright © 2020 Andriy Yezerskiy. All rights reserved.
//

import SwiftUI

struct TodayView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: TrackerItem.getTodayTrackerItems()) var trackerItems: FetchedResults<TrackerItem>
        
    var today: Date = Date()
        
    @State var shouldPresentAddTrackerView: Bool = false
    
    var body: some View {
        
        return NavigationView {
            VStack(alignment: .center, spacing: 10) {
                
                RingView(width: 300, height: 300, totalTrackedTime: trackerItems.reduce(0) { (result, item) -> TimeInterval in
                    return TimeInterval(result) + TimeInterval(truncating: item.timeTracked ?? NSNumber(integerLiteral: 0))
                })
                    .padding(.vertical, 40)
                
                VStack(spacing: 20) {
                    HStack {
                        Text("Trackers")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .padding(.leading, 20)
                        
                        Spacer()
                    }
                    
                    // Basic Empty State
                    if trackerItems.isEmpty {
                        VStack() {
                            Spacer()
                                
                            Text("Nothing tracked yet!")
                                .frame(alignment: .center)
                                .font(.headline)
                            
                            Spacer()
                        }
                    } else {
                        List() {
                            // ForEach is needed for deletion
                            ForEach(trackerItems, id: \.id) { trackerItem in
                                TrackerItemView(trackerItem: trackerItem)
                                    .padding(.vertical, 10)
                            }.onDelete { indexSet in
                                if let firstIndexSet = indexSet.first {
                                    let itemToDelete = self.trackerItems[firstIndexSet]
                                    self.managedObjectContext.delete(itemToDelete)
                                    
                                    do {
                                        try self.managedObjectContext.save()
                                    } catch {
                                        // Needs error handling and user prompt
                                        print(error)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(Text(today.asString(with: "MMM d, yyyy")), displayMode: .large)
            .navigationBarItems(leading: EditButton(),
                                trailing: Button( action: {
                                    self.shouldPresentAddTrackerView.toggle()
                                }) {
                                    Image(systemName: "plus")
                                })
            
            .sheet(isPresented: $shouldPresentAddTrackerView) {
                AddTrackerView().environment(\.managedObjectContext, self.managedObjectContext)
            }
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
        // Declare CoreData Context to avoid live preview crashes
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return TodayView().environment(\.managedObjectContext, context)
    }
}
