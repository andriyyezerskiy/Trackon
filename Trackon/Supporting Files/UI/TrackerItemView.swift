//
//  TrackerItemView.swift
//  Trackon
//
//  Created by Andriy Yezerskiy on 15/03/2020.
//  Copyright © 2020 Andriy Yezerskiy. All rights reserved.
//

import SwiftUI

struct TrackerItemView: View {
    
    var trackerItem: TrackerItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack() {
                Text(trackerItem.project ?? "")
                    .font(.headline)
                
                Spacer()
                
                Text(TimeInterval(exactly: trackerItem.timeTracked ?? 0)?.userReadable ?? "")
                    .font(.headline)
            }
            
            Text(trackerItem.task ?? "")
                .font(.subheadline)
            
            Text(trackerItem.trackerDescription ?? "")
                .font(.footnote)
                .lineLimit(2)
            
        }
    }
}

struct TrackerItemView_Previews: PreviewProvider {
    static var previews: some View {
        TrackerItemView(trackerItem: TrackerItem())
    }
}
