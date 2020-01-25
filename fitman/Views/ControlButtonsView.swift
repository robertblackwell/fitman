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
    let arrowLeft = #imageLiteral(resourceName: "ArrowLeft")
    let arrowRight = #imageLiteral(resourceName: "ArrowRight")
    let playImage = #imageLiteral(resourceName: "PlayIcon")
    let pauseImage = #imageLiteral(resourceName: "PauseIcon")
    var body: some View {
        let playPauseIcon = (self.state.buttonLabel == "Play") ? playImage : pauseImage
        return HStack(alignment: .center, spacing: 10) {
            Button(action: {
                self.state.previousButton()
            }) {
                HStack {
                    Image(nsImage: arrowLeft)
//                    Text("Previous")
//                    .font(.title)
//                    .fontWeight(.bold)
//                    .font(.system(size:30))
//                    .padding()
//                    .background(Color.white)
                }
            }
            .buttonStyle(PlainButtonStyle()).background(Color.yellow).cornerRadius(20)
            
            Button(action: {
                self.state.togglePause()
            }) {
                return Image(nsImage: playPauseIcon)
//                Text(self.state.buttonLabel)
//                    .font(.title)
//                    .fontWeight(.bold)
//                    .font(.system(size:30))
//                    .padding()
//                    .background(Color.white)
            }
            .buttonStyle(PlainButtonStyle()).background(Color.white).cornerRadius(20)

            Button(action: {
                self.state.nextButton()
            }) {
                Image(nsImage: arrowRight)
//                Text("Next")
//                    .font(.title)
//                    .fontWeight(.bold)
//                    .font(.system(size:30))
//                    .padding()
//                    .background(Color.white)
            }
            .buttonStyle(PlainButtonStyle()).background(Color.yellow).cornerRadius(20)

        }
    }
}

