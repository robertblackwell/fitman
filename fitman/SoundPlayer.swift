//
//  SoundPLayer.swift
//  nssound-replacement
//
//  Created by Robert BLACKWELL on 1/24/20.
//  Copyright © 2020 Robert Blackwell. All rights reserved.
//

import Foundation
import AVFoundation

class SoundPlayer {
    public static var notificationSoundLookupTable = [String: SystemSoundID]()

    public static func play(name: String) {
        if let soundID = notificationSoundLookupTable[name] {
               AudioServicesPlaySystemSound(soundID)
        } else {
            if let soundPath = Bundle.main.path(forResource: "Sounds/\(name)", ofType: nil) {
                let soundURL: NSURL = NSURL(fileURLWithPath: soundPath)
                var soundID  : SystemSoundID = 0
                let osStatus : OSStatus = AudioServicesCreateSystemSoundID(soundURL, &soundID)
                if osStatus == kAudioServicesNoError {
                    AudioServicesPlayAlertSound(soundID);
                    notificationSoundLookupTable[name] = (soundID)
                } else {
                    print("did not work")
                  // This happens in exceptional cases
                  // Handle it with no sound or retry
               }
           }
        }
    }
    deinit {
        for soundID in SoundPlayer.notificationSoundLookupTable.values {
           AudioServicesDisposeSystemSoundID(soundID)
        }
    }
}
