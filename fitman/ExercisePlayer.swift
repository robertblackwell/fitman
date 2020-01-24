import SwiftUI
import AVFoundation

enum PlayerState: String {
    case announcementRequired = "announcement_required"
    case annoucementPending = "announecement_pending"
    case annoucementDone = "announecement_done"
}
//
// Plays a single Exercise allowing the play to be paused and restarted.
// Creating another instance of this class for each new Exercise
//
class ExercisePlayer: Speaker {
    var frequency: Double
    var exercise: Exercise
    var tasks: Array<Task>
    public var onComplete: (()->())?
    public var onProgressReport: ((Double, Double)->())?
     var timer: Timer?
    var pauseFlag: Bool
    var runningFlag: Bool
    var announcementState = PlayerState.annoucementDone
    
    init(exercise: Exercise) {
        self.pauseFlag = false
        self.runningFlag = false
        self.announcementState = PlayerState.annoucementDone
        
        self.frequency = 0.1
        self.exercise = exercise
        self.tasks = buildTasks(exercise: self.exercise)
        super.init()
    }
    public func start(exercise: Exercise, frequency: Double, onProgress: ((Double, Double)->()), onComplete: (()->())  ) {
    
    }
    public func go() {
        self.announcementState = PlayerState.announcementRequired
        self.doPerform()
    }
    public func stop() {
        if self.timer != nil && self.announcementState == PlayerState.annoucementPending {
            self.stopSpeech()
        }
        self.timer?.invalidate()
        self.timer = nil
    }
    public func togglePause() {
        if (self.pauseFlag && self.announcementState == PlayerState.annoucementPending) {
            self.resumeSpeech()
        } else if (!self.pauseFlag && self.announcementState == PlayerState.annoucementPending) {
            self.pauseSpeech()
        }
        self.pauseFlag = !self.pauseFlag
    }
    override func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        // note this may be executed not on the main thread
        DispatchQueue.main.async {
            self.announcementState = PlayerState.annoucementDone
        }
    }
    private func doPerform() {
        var lastTime = NSDate().timeIntervalSince1970
        var elapsed = 0.0
        let duration: Double = durationOfTasks(tasks: self.tasks)
        self.runningFlag = true
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) {timer in
            if self.pauseFlag {
                lastTime = NSDate().timeIntervalSince1970
                return
            }
            if (self.announcementState == PlayerState.announcementRequired) {
                self.announcementState = PlayerState.annoucementPending
                self.announce(self.exercise)
                return
            }
            if (self.announcementState == PlayerState.annoucementPending) {
                return
            }
            let now = NSDate().timeIntervalSince1970
            elapsed = elapsed + (now - lastTime)
            lastTime = now
            
            self.tasks = attemptToPerformTask(tasks: self.tasks, elapsed: elapsed)

            if let cbProgress = self.onProgressReport {
                cbProgress(elapsed, duration)
            }

            if (elapsed > duration) {
                timer.invalidate()
                self.timer = nil
                self.runningFlag = false
                if let cb = self.onComplete {
                    cb()
                    return
                }else {
                    return
                }
            }
        }
    }
}
