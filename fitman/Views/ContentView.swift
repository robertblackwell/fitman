//
//  ContentView.swift
//  Timed
//
//  Created by Brendon Blackwell on 08.01.20.
//  Copyright © 2020 Brendon Blackwell. All rights reserved.
//

import SwiftUI

fileprivate let flag = false

// Structire the app as a single view
struct ContentView: View {
    
    @ObservedObject var controller: ExerciseController
    let sessionLabels: Array<String>
    @State var playPauseLabel: String = "Play"

    var body: some View {
//        let sessionLabels: Array<String> = Array(self.controller.exLabels)

        return VStack(alignment: HorizontalAlignment.center, spacing: 20)
        {
            if ( (controller.model.buttonState != ViewModelState.Playing)
                && (controller.model.buttonState != ViewModelState.Paused)) {
                HStack(alignment: .center, spacing: 20)
                {
                    Spacer()
                    DefaultsTopView(controller: controller,
                        sessionLabels: sessionLabels,
                        selectedExerciseSet: $controller.selectedSessionIndex,
                        preludeDelay: $controller.model.preludeDelayString 
                        )
//                    Spacer()
                }
            } else {
                HStack(alignment: .center, spacing: 20)
                {
                    Spacer()
                    RunTopView(sessionName: "\(sessionLabels[self.controller.selectedSessionIndex])")
//                    Spacer()
                }
            }
            #if CV_DIVIDE
            ExDivider()
            #endif
            HStack(alignment: .center, spacing: 20)
            {
                ControlButtons(state: controller.model, playPauseLabel: playPauseLabel)
            }.padding(10)
            RunBottomView(state: $controller.model, discFlag: flag)
            Spacer()
        }.background(Color(.sRGB, white: 0.8, opacity: 1))
        
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

