//
//  LGAudioRecorder.swift
//  LGChatViewController
//
//  Created by jamy on 10/13/15.
//  Copyright © 2015 jamy. All rights reserved.
//

import UIKit
import AVFoundation

protocol LGAudioRecorderDelegate {
    func audioRecorderUpdateMetra(_ metra: Float)
}


let soundPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!

let audioSettings: [String: AnyObject] = [AVLinearPCMIsFloatKey: NSNumber(value: false as Bool),
    AVLinearPCMIsBigEndianKey: NSNumber(value: false as Bool),
    AVLinearPCMBitDepthKey: NSNumber(value: 16 as Int32),
    AVFormatIDKey: NSNumber(value: kAudioFormatLinearPCM as UInt32),
    AVNumberOfChannelsKey: NSNumber(value: 1 as Int32), AVSampleRateKey: NSNumber(value: 16000 as Int32),
    AVEncoderAudioQualityKey: NSNumber(value: AVAudioQuality.medium.rawValue as Int)]


class LGAudioRecorder: NSObject, AVAudioRecorderDelegate {
    
    var audioData: Data!
    var operationQueue: OperationQueue!
    var recorder: AVAudioRecorder!
    
    var startTime: Double!
    var endTimer: Double!
    var timeInterval: NSNumber!
    
    var delegate: LGAudioRecorderDelegate?
    
    convenience init(fileName: String) {
        self.init()
        
        let filePath = URL(fileURLWithPath: (soundPath as NSString).appendingPathComponent(fileName))
        
        recorder = try! AVAudioRecorder(url: filePath, settings: audioSettings)
        recorder.delegate = self
        recorder.isMeteringEnabled = true
        
    }
    
    override init() {
        operationQueue = OperationQueue()
        super.init()
    }
    
    func startRecord() {
        startTime = Date().timeIntervalSince1970
        perform(#selector(LGAudioRecorder.readyStartRecord), with: self, afterDelay: 0.5)
    }
    
    func readyStartRecord() {
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
        } catch {
            NSLog("setCategory fail")
            return
        }
        
        do {
            try audioSession.setActive(true)
        } catch {
            NSLog("setActive fail")
            return
        }
        recorder.record()
        let operation = BlockOperation()
        operation.addExecutionBlock(updateMeters)
        operationQueue.addOperation(operation)
    }
    
    
    func stopRecord() {
        endTimer = Date().timeIntervalSince1970
        timeInterval = nil
        if (endTimer - startTime) < 0.5 {
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(LGAudioRecorder.readyStartRecord), object: self)
        } else {
            timeInterval = NSNumber(value: NSNumber(value: recorder.currentTime as Double).int32Value as Int32)
            if timeInterval.int32Value < 1 {
                perform(#selector(LGAudioRecorder.readyStopRecord), with: self, afterDelay: 0.4)
            } else {
                readyStopRecord()
            }
        }
        operationQueue.cancelAllOperations()
    }
    
    
    func readyStopRecord() {
        recorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(false, with: .notifyOthersOnDeactivation)
        } catch {
            // no-op
        }
        audioData = try? Data(contentsOf: recorder.url)
    }
    
    func updateMeters() {
        repeat {
            recorder.updateMeters()
            timeInterval = NSNumber(value: NSNumber(value: recorder.currentTime as Double).floatValue as Float)
            let averagePower = recorder.averagePower(forChannel: 0)
           // let pearPower = recorder.peakPowerForChannel(0)
          //  NSLog("%@   %f  %f", timeInterval, averagePower, pearPower)
            delegate?.audioRecorderUpdateMetra(averagePower)
            Thread.sleep(forTimeInterval: 0.2)
        } while(recorder.isRecording)
    }
    
    // MARK: audio delegate
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        NSLog("%@", (error?.localizedDescription)!)
    }
}
