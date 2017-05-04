//
//  LGRecordView.swift
//  record
//
//  Created by jamy on 11/6/15.
//  Copyright © 2015 jamy. All rights reserved.
//  该模块未使用autolayout

import UIKit
import AVFoundation


private let buttonW: CGFloat = 60
class LGRecordVideoView: UIView {
    
    var videoView: UIView!
    var indicatorView: UILabel!
    var recordButton: UIButton!
    var progressView: UIProgressView!
    var progressView2: UIProgressView!
    var recordVideoModel: LGRecordVideoModel!
    var preViewLayer: AVCaptureVideoPreviewLayer!
    
    var recordTimer: Timer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }
    
    func customInit() {
        backgroundColor = UIColor.black
        
        if TARGET_IPHONE_SIMULATOR == 1 {
            NSLog("simulator can't do this!!!")
        } else {
            recordVideoModel = LGRecordVideoModel()
            
            videoView = UIView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height * 0.7))
            videoView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(videoView)
            
            preViewLayer = AVCaptureVideoPreviewLayer(session: recordVideoModel.captureSession)
            preViewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
            preViewLayer.frame = videoView.bounds
            videoView.layer.insertSublayer(preViewLayer, at: 0)
            
            recordButton = UIButton(type: .custom)
            recordButton.setTitleColor(UIColor.orange, for: UIControlState())
            recordButton.layer.cornerRadius = buttonW / 2
            recordButton.layer.borderWidth = 1.5
            recordButton.layer.borderColor = UIColor.orange.cgColor
            recordButton.setTitle("按住拍", for: UIControlState())
            recordButton.addTarget(self, action: #selector(LGRecordVideoView.buttonTouchDown), for: .touchDown)
            recordButton.addTarget(self, action: #selector(LGRecordVideoView.buttonDragOutside), for: .touchDragOutside)
            recordButton.addTarget(self, action: #selector(LGRecordVideoView.buttonCancel), for: .touchUpOutside)
            recordButton.addTarget(self, action: #selector(LGRecordVideoView.buttonTouchUp), for: .touchUpInside)
            addSubview(recordButton)
            
            progressView = UIProgressView(frame: CGRect.zero)
            progressView.progressTintColor = UIColor.black
            progressView.trackTintColor = UIColor.orange
            progressView.isHidden = true
            addSubview(progressView)
            
            progressView2 = UIProgressView(frame: CGRect.zero)
            progressView2.progressTintColor = UIColor.black
            progressView2.trackTintColor = UIColor.orange
            progressView2.isHidden = true
            addSubview(progressView2)
            progressView2.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
            
            indicatorView = UILabel()
            indicatorView.textColor = UIColor.white
            indicatorView.font = UIFont.systemFont(ofSize: 12.0)
            indicatorView.backgroundColor = UIColor.red
            indicatorView.isHidden = true
            addSubview(indicatorView)
            
            recordButton.bounds = CGRect(x: 0, y: 0, width: buttonW, height: buttonW)
            recordButton.center = CGPoint(x: center.x, y: videoView.frame.height + buttonW)
            
            progressView.frame = CGRect(x: 0, y: videoView.frame.height, width: bounds.width / 2, height: 2)
            progressView2.frame = CGRect(x: bounds.width / 2 - 1, y: videoView.frame.height, width: bounds.width / 2 + 1, height: 2)
            
            indicatorView.center = CGPoint(x: center.x, y: videoView.frame.height - 20)
            indicatorView.bounds = CGRect(x: 0, y: 0, width: 50, height: 20)
        }
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if TARGET_IPHONE_SIMULATOR == 0 {
            recordVideoModel.start()
        }
    }
    
    func buttonTouchDown() {
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.recordButton.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }, completion: { (finish) -> Void in
                self.recordButton.isHidden = true
        }) 
        
        recordVideoModel.beginRecord()
        stopTimer()
        self.progressView.isHidden = false
        self.progressView2.isHidden = false
        indicatorView.isHidden = false
        indicatorView.text = "上移取消"
        recordTimer = Timer(timeInterval: 1.0, target: self, selector: #selector(LGRecordVideoView.recordTimerUpdate), userInfo: nil, repeats: true)
        RunLoop.main.add(recordTimer, forMode: RunLoopMode.commonModes)
    }
    
    func buttonDragOutside() {
        indicatorView.isHidden = false
        indicatorView.text = "松手取消"
    }
    
    func buttonCancel() {
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.recordButton.isHidden = false
            self.recordButton.transform = CGAffineTransform.identity
            }, completion: { (finish) -> Void in
                self.indicatorView.isHidden = true
                self.progressView.isHidden = true
                self.progressView.progress = 0
                self.progressView2.isHidden = true
                self.progressView2.progress = 0
                self.stopTimer()
        }) 
        recordVideoModel.cancelRecord()
    }
    
    func buttonTouchUp() {
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.recordButton.isHidden = false
            self.recordButton.transform = CGAffineTransform.identity
            }, completion: { (finish) -> Void in
                self.indicatorView.isHidden = true
                self.progressView.isHidden = true
                self.progressView.progress = 0
                self.progressView2.isHidden = true
                self.progressView2.progress = 0
                self.stopTimer()
        }) 
        recordVideoModel.complectionRecord()
    }
    
    func stopTimer() {
        if recordTimer != nil {
            recordTimer.invalidate()
            recordTimer = nil
        }
    }
    
    func recordTimerUpdate() {
        if progressView.progress == 1 {
            buttonTouchUp()
        } else {
            progressView.progress += 0.1
            progressView2.progress += 0.1
        }
    }
}

