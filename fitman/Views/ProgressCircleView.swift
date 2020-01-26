//
//  ContentView.swift
//  Timed
//
//  Created by Brendon Blackwell on 08.01.20.
//  Copyright © 2020 Brendon Blackwell. All rights reserved.
//

import SwiftUI
fileprivate let flag: Bool = false


struct ProgressCircle: View {

    @ObservedObject var session: SessionViewModel
    var discFlag: Bool
    var body: some View {
        let flag: Bool = self.discFlag
        
        let lineWidth: CGFloat = (flag) ? 200.0 : 20.0
        let minWidthHeight: CGFloat = (flag) ? 200.0 : 500.0
        
        let bgColor = NSColor(named: NSColor.Name("progressBarBg"))
        let barColor = (flag)
            ? NSColor(named: NSColor.Name("Progressbar"))
            : NSColor(named: NSColor.Name("exerciseProgressBar"))
//        let barColor = (session.stateMachine?.state != SM_State.prelude)
//            ? NSColor(named: NSColor.Name("exerciseProgressBar"))
//            : NSColor(named: NSColor.Name("countInProgressBar"))
        
        return VStack() {
            ZStack {
                Circle()
                    .stroke(Color(bgColor!), lineWidth: lineWidth)
                    .frame(minWidth: minWidthHeight, minHeight: minWidthHeight)
                    .rotationEffect(Angle(degrees:-90))
                Circle()
                    .trim(from: 0.0, to: CGFloat(session.elapsed / session.duration))
                    .stroke(Color(barColor!), lineWidth: lineWidth)
                    .frame(minWidth: minWidthHeight, minHeight: minWidthHeight )
                    .rotationEffect(Angle(degrees:-90))
            }.padding()
        }
    }
}

