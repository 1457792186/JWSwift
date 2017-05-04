
//
//  LGAVPlayView.swift
//  player
//
//  Created by jamy on 11/4/15.
//  Copyright © 2015 jamy. All rights reserved.
//

import UIKit
import AVFoundation

@IBDesignable
class LGAVPlayView: UIView {
    
    var playView: UIView!
    var slider: UISlider!
    var timerIndicator: UILabel!
  
    // MARK: - lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    deinit {
        NSLog("deinit")
    }
    
    func setup() {
        backgroundColor = UIColor.black
        playView = UIView()
        
        slider = UISlider()
        slider.setThumbImage(UIImage.imageWithColor(UIColor.red), for: UIControlState())
        
        timerIndicator = UILabel()
        timerIndicator.font = UIFont.systemFont(ofSize: 12.0)
        timerIndicator.textColor = UIColor.white
        
        addSubview(playView)
        addSubview(slider)
        addSubview(timerIndicator)
        
        playView.translatesAutoresizingMaskIntoConstraints = false
        slider.translatesAutoresizingMaskIntoConstraints = false
        timerIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(NSLayoutConstraint(item: playView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: playView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: playView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: playView, attribute: .bottom, relatedBy: .equal, toItem: slider, attribute: .top, multiplier: 1, constant: -5))
        
        addConstraint(NSLayoutConstraint(item: slider, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 10))
        addConstraint(NSLayoutConstraint(item: slider, attribute: .right, relatedBy: .equal, toItem: timerIndicator, attribute: .left, multiplier: 1, constant: -5))
        addConstraint(NSLayoutConstraint(item: slider, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -5))
        
        addConstraint(NSLayoutConstraint(item: timerIndicator, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -5))
        addConstraint(NSLayoutConstraint(item: timerIndicator, attribute: .centerY, relatedBy: .equal, toItem: slider, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
     override class var layerClass : AnyClass {
        return AVPlayerLayer.self
    }
}
