//
//  LGRecordVideo.swift
//  record
//
//  Created by jamy on 11/6/15.
//  Copyright © 2015 jamy. All rights reserved.
//

import Foundation
import AVFoundation
import Photos
import UIKit


private let needSaveToPHlibrary = false

class LGRecordVideoModel: NSObject, AVCaptureFileOutputRecordingDelegate {
    var captureSession: AVCaptureSession!
    var captureDeviceInput: AVCaptureDeviceInput!
    var captureMovieFileOutput: AVCaptureMovieFileOutput!
    var backgroundTaskIdentifier: UIBackgroundTaskIdentifier!
    
    var filePath: URL?
    var fileName: String!
    
    var complectionClosure: ((URL) -> Void)?
    var cancelClosure: ((Void) -> Void)?
    
    override init() {
        super.init()
        captureSession = AVCaptureSession()
        let captureDevice = getCameraDevice(.back)
        if captureDevice == nil {
            return
        }
        let audioCaptureDevice = AVCaptureDevice.devices(withMediaType: AVMediaTypeAudio).first as! AVCaptureDevice
        
        var audioCaptureDeviceInput: AVCaptureDeviceInput?
        do {
            try audioCaptureDeviceInput = AVCaptureDeviceInput(device: audioCaptureDevice)
        } catch let error as NSError {
            NSLog("%@", error)
            return
        }
        
        do {
            try captureDeviceInput = AVCaptureDeviceInput(device: captureDevice)
        } catch let error as NSError {
            NSLog("%@", error)
            return
        }
        
        captureSession.beginConfiguration()
        captureMovieFileOutput = AVCaptureMovieFileOutput()
        
        if captureSession.canAddInput(captureDeviceInput) {
            captureSession.addInput(captureDeviceInput)
            captureSession.addInput(audioCaptureDeviceInput!)
        }
        
        if captureSession.canAddOutput(captureMovieFileOutput) {
            captureSession.addOutput(captureMovieFileOutput)
            let connection = captureMovieFileOutput.connection(withMediaType: AVMediaTypeVideo)
            if (connection?.isVideoStabilizationSupported)! {
                connection?.preferredVideoStabilizationMode = .auto
            }
        }
        captureSession.commitConfiguration()
        
        addNotificationToDevice(captureDevice!)
    }
 
    deinit {
        captureSession.removeInput(captureDeviceInput)
        captureSession.removeInput(captureDeviceInput)
        captureSession.removeOutput(captureMovieFileOutput)
        removeNotification()
    }
    
    func getCameraDevice(_ position: AVCaptureDevicePosition) -> (AVCaptureDevice?) {
        let devices = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo)
        for device in devices! {
            let device = device as! AVCaptureDevice
            if device.position == position {
                return device
            }
        }
        return nil
    }
    
    func start() {
        captureSession.startRunning()
    }
    
    func stop() {
        captureSession.stopRunning()
    }
    
    func addNotificationToDevice(_ newCaptureDevice: AVCaptureDevice) {
        let captureDevice = captureDeviceInput.device
        do {
            try captureDevice?.lockForConfiguration()
        } catch let error as NSError {
            NSLog("%@", error)
            return
        }
        captureDevice?.isSubjectAreaChangeMonitoringEnabled = true
        captureDevice?.unlockForConfiguration()
        
        NotificationCenter.default.addObserver(self, selector: #selector(LGRecordVideoModel.notificateAreChanged(_:)), name: NSNotification.Name.AVCaptureDeviceSubjectAreaDidChange, object: newCaptureDevice)
        
        NotificationCenter.default.addObserver(self, selector: #selector(LGRecordVideoModel.notificateSessionError(_:)), name: NSNotification.Name.AVCaptureSessionRuntimeError, object: captureSession)
        NotificationCenter.default.addObserver(self, selector: #selector(LGRecordVideoModel.sessionWasInterrupted(_:)), name: NSNotification.Name.AVCaptureSessionWasInterrupted, object: captureSession)
        NotificationCenter.default.addObserver(self, selector: #selector(LGRecordVideoModel.sessionInterruptEnd(_:)), name: NSNotification.Name.AVCaptureSessionInterruptionEnded, object: captureSession)
    }
    
    func removeNotificationFromDevice(_ oldCaptureDevice: AVCaptureDevice) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVCaptureDeviceSubjectAreaDidChange, object: oldCaptureDevice)
    }
    
    func removeNotification() {
        NotificationCenter.default.removeObserver(self)
    }
    
    func notificateAreChanged(_ notification: Notification) {
        
    }
    
    func sessionWasInterrupted(_ notification: Notification) {
        NSLog("------sessionWasInterrupted---------")
    }
    
    func sessionInterruptEnd(_ notification: Notification) {
         NSLog("------sessionInterruptEnd---------")
    }
    
    func notificateSessionError(_ notification: Notification) {
        NSLog("notificateSessionError")
    }
    
    func beginRecord() {
        if !captureMovieFileOutput.isRecording {
            if UIDevice.current.isMultitaskingSupported {
                backgroundTaskIdentifier = UIApplication.shared.beginBackgroundTask(expirationHandler: nil)
            }
            
            var fileName = String(stringInterpolationSegment: arc4random_uniform(1000))
            fileName = fileName + ".m4v"
            let filePath = NSString(string: NSTemporaryDirectory()).appendingPathComponent(fileName)
            let fileUrl = URL(fileURLWithPath: filePath)
            
            self.fileName = fileName
            self.filePath = fileUrl
            
            captureMovieFileOutput.startRecording(toOutputFileURL: fileUrl, recordingDelegate: self)
        } else {
            captureMovieFileOutput.stopRecording()
        }
    }
    
    func complectionRecord() {
        if captureMovieFileOutput.isRecording {
            captureMovieFileOutput.stopRecording()
        }
    }
    
    func cancelRecord() {
        if captureMovieFileOutput.isRecording {
            captureMovieFileOutput.stopRecording()
        }
        if filePath != nil {
            do {
                try FileManager.default.removeItem(at: filePath!)
            } catch let error as NSError {
                NSLog("remove file error: %@", error)
            }
        }
        
        if let cancelOperation = cancelClosure {
            cancelOperation()
        }
    }
    
    func changeCameraPosition() {
        let currentDevice = captureDeviceInput.device
        let currentPosition = currentDevice?.position
        removeNotificationFromDevice(currentDevice!)
        
        var changePosition: AVCaptureDevicePosition = .front
        if currentPosition == .unspecified || currentPosition == .front {
            changePosition = .back
        }
        
        if let changeDevice = getCameraDevice(changePosition) {
            addNotificationToDevice(changeDevice)
            var changeDeviceInput: AVCaptureDeviceInput!
            do {
                changeDeviceInput = try AVCaptureDeviceInput(device: changeDevice)
            } catch let error as NSError {
                NSLog("changeCamera: %@", error)
                return
            }
            
            captureSession.beginConfiguration()
            captureSession.removeInput(captureDeviceInput)
            if captureSession.canAddInput(changeDeviceInput) {
                captureSession.addInput(changeDeviceInput)
                captureDeviceInput = changeDeviceInput
            }
            captureSession.commitConfiguration()
        }
    }
    
    func setFlashMode(_ flashMode: AVCaptureFlashMode) {
        let captureDevice = captureDeviceInput.device
        do {
            try captureDevice?.lockForConfiguration()
        } catch let error as NSError {
            NSLog("%@", error)
            return
        }
        if (captureDevice?.isFlashModeSupported(flashMode))! {
            captureDevice?.flashMode = flashMode
        }
        captureDevice?.unlockForConfiguration()
    }
    
    
    func setFocusMode(_ focusMode: AVCaptureFocusMode) {
        let captureDevice = captureDeviceInput.device
        do {
            try captureDevice?.lockForConfiguration()
        } catch let error as NSError {
            NSLog("%@", error)
            return
        }
        if (captureDevice?.isFocusModeSupported(focusMode))! {
            captureDevice?.focusMode = focusMode
        }
        captureDevice?.unlockForConfiguration()
    }
    
    func setFocusExposureMode(_ focusMode: AVCaptureFocusMode, exposureMode: AVCaptureExposureMode, point: CGPoint) {
        let captureDevice = captureDeviceInput.device
        do {
            try captureDevice?.lockForConfiguration()
        } catch let error as NSError {
            NSLog("%@", error)
            return
        }
        
        if (captureDevice?.isFocusModeSupported(focusMode))! {
            captureDevice?.focusMode = focusMode
        }
        if (captureDevice?.isFocusPointOfInterestSupported)! {
            captureDevice?.focusPointOfInterest = point
        }
        
        if (captureDevice?.isExposureModeSupported(exposureMode))! {
            captureDevice?.exposureMode = exposureMode
        }
        if (captureDevice?.isExposurePointOfInterestSupported)! {
            captureDevice?.exposurePointOfInterest = point
        }
        
        captureDevice?.unlockForConfiguration()
    }
 
    // MARK: delegate
    
    func capture(_ captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAt fileURL: URL!, fromConnections connections: [Any]!) {
        NSLog("begin record")
    }
    
    func capture(_ captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAt outputFileURL: URL!, fromConnections connections: [Any]!, error: Error!) {
        NSLog("record finish")
        if error == nil {
            
            let lastBackgroundTaskIdentifier = backgroundTaskIdentifier
            self.backgroundTaskIdentifier = UIBackgroundTaskInvalid
            if let complection = complectionClosure {
                complection(filePath!)
            }
            
            if needSaveToPHlibrary {
                PHPhotoLibrary.shared().performChanges({ () -> Void in
                    PHAssetCreationRequest.forAsset().addResource(with: .video, fileURL: outputFileURL, options: nil)
                    }) { (finish, errors) -> Void in
                        if errors == nil {
                            NSLog("保存成功")
                        } else {
                            NSLog("保存失败：%@", errors!)
                        }
                        if lastBackgroundTaskIdentifier != UIBackgroundTaskInvalid {
                            UIApplication.shared.endBackgroundTask(lastBackgroundTaskIdentifier!)
                        }
                }
            }
        } else {
            NSLog("record error:%@", error)
        }
    }
    
}
