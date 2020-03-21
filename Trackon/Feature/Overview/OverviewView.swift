//
//  OverviewView.swift
//  Trackon
//
//  Created by Andriy Yezerskiy on 14/03/2020.
//  Copyright © 2020 Andriy Yezerskiy. All rights reserved.
//

import SwiftUI

struct OverviewView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: TrackerItem.getAllTrackerItems()) var trackerItems: FetchedResults<TrackerItem>
    
    @State var shouldPresentAddTrackerView: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
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
            .navigationBarTitle("Overview")
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
}

struct OverviewView_Previews: PreviewProvider {
    static var previews: some View {
        // Declare CoreData Context to avoid live preview crashes
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return OverviewView().environment(\.managedObjectContext, context)
    }
}
