//
//  LGVideoController.swift
//  LGWeChatKit
//
//  Created by jamy on 11/4/15.
//  Copyright © 2015 jamy. All rights reserved.
//

import UIKit
import AVFoundation

class LGVideoController: UIViewController {

    var totalTimer: String!
    var playItem: AVPlayerItem!
    var playView: LGAVPlayView!
    var timerObserver: AnyObject?
    
     init() {
        super.init(nibName: nil, bundle: nil)
        playView = LGAVPlayView(frame: view.bounds)
         view.addSubview(playView)
        playView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(LGVideoController.tapView(_:))))
    }
    
    func tapView(_ gesture: UITapGestureRecognizer) {
        removeConfigure()
        dismiss(animated: true) { () -> Void in
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        removeConfigure()
    }
    
    func removeConfigure() {
        NotificationCenter.default.removeObserver(self)
        playItem.removeObserver(self, forKeyPath: "status", context: nil)
        if let observer = timerObserver {
            let layer = playView.layer as! AVPlayerLayer
            layer.player?.removeTimeObserver(observer)
        }
        playView.removeFromSuperview()
        playView = nil
    }
    
    // MARK: - 初始化配置
    
    func setPlayUrl(_ url: URL) {
        playItem = AVPlayerItem(url: url)
        configurationItem()
    }
    
    func setPlayAsset(_ asset: AVAsset) {
        playItem = AVPlayerItem(asset: asset)
        configurationItem()
    }
    
    func configurationItem() {
        let play = AVPlayer(playerItem: playItem)
        let layer = playView.layer as! AVPlayerLayer
        layer.player = play
        
        playItem.addObserver(self, forKeyPath: "status", options: .new, context: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LGVideoController.videoPlayDidEnd(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "status" {
            if playItem.status == .readyToPlay {
                let dutation = playItem.duration
                let totalSecond = CGFloat(playItem.duration.value) / CGFloat(playItem.duration.timescale)
                totalTimer = converTimer(totalSecond)
                configureSlider(dutation)
                monitoringPlayback(self.playItem)
                
                let layer = playView.layer as! AVPlayerLayer
                layer.player?.play()
            }
        }
    }
    
    func videoPlayDidEnd(_ notifation: Notification) {
        playItem.seek(to: CMTimeMake(0, 1))
        let layer = playView.layer as! AVPlayerLayer
        layer.player?.play()
    }

    // MARK: operation
    
    func converTimer(_ time: CGFloat) -> String {
        let date = Date(timeIntervalSince1970: Double(time))
        let dateFormat = DateFormatter()
        if time / 3600 >= 1 {
            dateFormat.dateFormat = "HH:mm:ss"
        } else {
            dateFormat.dateFormat = "mm:ss"
        }
        let formatTime = dateFormat.string(from: date)
        
        return formatTime
    }
    
    
    func configureSlider(_ duration: CMTime) {
        playView.slider.maximumValue = Float(CMTimeGetSeconds(duration))
    }
    
    func monitoringPlayback(_ item: AVPlayerItem) {
        let layer = playView.layer as! AVPlayerLayer
        timerObserver = layer.player!.addPeriodicTimeObserver(forInterval: CMTimeMake(1, 1), queue: nil, using: { (time) -> Void in
            let currentSecond = item.currentTime().value / Int64(item.currentTime().timescale)
            self.playView.slider.setValue(Float(currentSecond), animated: true)
            let timeStr = self.converTimer(CGFloat(currentSecond))
            self.playView.timerIndicator.text = "\(timeStr)/\(self.totalTimer)"
        }) as AnyObject?
    }
}
