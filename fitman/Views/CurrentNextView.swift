//
//  ContentView.swift
//  Timed
//
//  Created by Brendon Blackwell on 08.01.20.
//  Copyright © 2020 Brendon Blackwell. All rights reserved.
//

import SwiftUI


struct CurrentPrevNextView: View {
    @ObservedObject var session: SessionViewModel
    @Binding var current: Int
    
    var body: some View {
    
//        let prev = session.exercises[safe: current-1]
        let curr = session.exercises[safe: current]
        let next = session.exercises[safe: current+1]
        
        return VStack(alignment: .center, spacing: 20) {
//            Row(exercise: prev, isCurrent: false)
            Row(exercise: curr, isCurrent: true)
            Row(exercise: next, isCurrent: false)
        }
    }
}

struct Row: View {
    var exercise: Exercise?
    var isCurrent: Bool

    var body: some View {
        
        let currColor = NSColor(named: NSColor.Name("currentExcerciseLabel"))
        let nextColor = NSColor(named: NSColor.Name("nextExerciseLabel"))
    
        let fontSize: CGFloat = !isCurrent ? 40 : 60
        let fontColor: Color = !isCurrent ? Color(nextColor!) : Color(currColor!)
        let labelStr: String = (exercise != nil) ? exercise!.label : " "
//        let durationStr: String = (exercise != nil) ? String(exercise!.duration) : " "
        
        return HStack(alignment: .center, spacing: 10) {
            Spacer()
            HStack(alignment: .bottom, spacing: 10, content: {
                
                Text("\(labelStr)")
                    .font(.custom("Futura", size: fontSize))
                    .foregroundColor(fontColor)
                    
                
//                Text("\(durationStr)s")
//                    .font(.custom("Futura", size: 13))
//                    .foregroundColor(Color(red: 0.8, green: 0.8, blue: 0.8))
//                    .baselineOffset(8)
            })
            Spacer()
        }
    }
}
