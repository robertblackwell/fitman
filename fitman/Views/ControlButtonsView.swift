//
//  ContentView.swift
//  Timed
//
//  Created by Brendon Blackwell on 08.01.20.
//  Copyright © 2020 Brendon Blackwell. All rights reserved.
//

import SwiftUI


struct ControlButtons: View {
    @ObservedObject var state: SessionViewModel
    @State var playPauseLabel: String = "Play"

    var body: some View {
        return HStack(alignment: .center, spacing: 20) {
            Button(action: {
                self.state.previousButton()
            }) {
                Text("Previous")
            }
            Button(action: {
                self.state.togglePause()
            }) {
                Text(self.state.buttonLabel)
            }
            Button(action: {
                self.state.nextButton()
            }) {
                Text("Next")
            }
        }
    }
}

