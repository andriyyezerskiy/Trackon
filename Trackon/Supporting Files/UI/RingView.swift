//
//  RingView.swift
//  Trackon
//
//  Created by Andriy Yezerskiy on 14/03/2020.
//  Copyright © 2020 Andriy Yezerskiy. All rights reserved.
//

import SwiftUI

struct RingView: View {
    
    var gradientStart = Color("ringGradinetStart")
    var gradientEnd = Color("ringGradientEnd")
    var lineWidth: CGFloat = 35
    var width: CGFloat
    var height: CGFloat
    
    var dailyGoal: TimeInterval = 28800
    var totalTrackedTime: TimeInterval
    
    var body: some View {
        // Calculate the progress of totalTrackedTime in relation to dailyGoal set by the user
        let progress = CGFloat(1 - (totalTrackedTime / dailyGoal))
        
        // Due to calculation of progress we have to specify at which point in code the view is returned
        // Wrapped in a VStack to provide correct frame to the ZStack
        return VStack {
            ZStack {
                // Background circle shape
                Circle()
                    .stroke(gradientStart.opacity(0.2), style: StrokeStyle(lineWidth: lineWidth))

                Circle()
                    .trim(from: progress, to: 1)
                    .stroke(LinearGradient(gradient: Gradient(colors: [gradientStart, gradientEnd]), startPoint: .topTrailing, endPoint: .bottomLeading), style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                    .rotationEffect(Angle(degrees: 90))
                    .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                    .shadow(color: gradientStart.opacity(0.3), radius: lineWidth, x: 0, y: lineWidth)
                    .animation(.spring())

                VStack(alignment: .center, spacing: 5) {
                    Text("\(totalTrackedTime.userReadable)")
                        .font(.footnote)
                        .fontWeight(.bold)
                    
                    Text("TRACKED TODAY")
                        .font(.caption)
                        .fontWeight(.light)
                }
            }
            .padding(.all)
            .frame(width: width, height: height, alignment: .center)
        }
    }
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        RingView(width: 300, height: 300, totalTrackedTime: 20000)
    }
}

