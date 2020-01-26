//
//  ContentView.swift
//  Timed
//
//  Created by Brendon Blackwell on 08.01.20.
//  Copyright © 2020 Brendon Blackwell. All rights reserved.
//

import SwiftUI
//Color(hex: 0x000000)
//Color(hex: 0x000000, alpha: 0.2)
extension Color {
    init(hex: Int, alpha: Double = 1) {
        let components = (
            R: Double((hex >> 16) & 0xff) / 255,
            G: Double((hex >> 08) & 0xff) / 255,
            B: Double((hex >> 00) & 0xff) / 255
        )
        self.init(
            .sRGB,
            red: components.R,
            green: components.G,
            blue: components.B,
            opacity: alpha
        )
    }
}
fileprivate let flag = false
fileprivate let appIcon = #imageLiteral(resourceName: "fitman")
fileprivate let bottomBackgroundColor = Color(.sRGB, white: 0.99, opacity: 0.5)
fileprivate let topLineSegmentWidth: CGFloat = 500.0
// Structire the app as a single view
struct ContentView: View {
    
    @ObservedObject var controller: ExerciseController
    let sessionLabels: Array<String>
    @State var playPauseLabel: String = "Play"
    var body: some View {

        return VStack(alignment: HorizontalAlignment.center, spacing: 10)
        {
            VStack(spacing:20) {
                HStack(alignment: VerticalAlignment.center, spacing: 20)
                {
//                    Spacer()
                    HStack(alignment: .center)
                    {
                        Image(nsImage: appIcon)
                        
                    }.frame(width:topLineSegmentWidth)
                    Spacer()
                    ControlButtons(state: controller.model).frame(width:topLineSegmentWidth)
                    Spacer()
                    SessionPicker(controller: self.controller, exLabels: sessionLabels, selectedExerciseSet: $controller.selectedSessionIndex).frame(width:topLineSegmentWidth)
 //                    Text("").frame(width:300)//Image(nsImage: icon).frame(width:300, height:200)
//                    Spacer()

                }.padding(40)
            }.background(Color(hex: 0xffffff))
            VStack() {
                Spacer()
                RunBottomView(state: $controller.model, discFlag: flag)
                Spacer()
            }
        }.background(bottomBackgroundColor)
        
    }
}
// custom divider between top and bottom part of screen
struct ExDivider: View {
    let color: Color = .black
    let width: CGFloat = 2
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: width)
            .edgesIgnoringSafeArea(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        let exerciseController = ExerciseController()
        
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView(
            controller: exerciseController, sessionLabels: exerciseController.exLabels
            )
        
        return contentView
    }
}

