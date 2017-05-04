//
//  LGRecordIndicatorView.swift
//  LGChatViewController
//
//  Created by jamy on 10/15/15.
//  Copyright © 2015 jamy. All rights reserved.
//

import UIKit

class LGRecordIndicatorView: UIView {
    
    let imageView: UIImageView
    let textLabel: UILabel
    let images:[UIImage]
    
    override init(frame: CGRect) {
        textLabel = UILabel()
        textLabel.textAlignment = .center
        textLabel.font = UIFont.systemFont(ofSize: 13.0)
        textLabel.text = "手指上滑,取消发送"
        textLabel.textColor = UIColor.black
        
        images = [UIImage(named: "record_animate_01")!,
            UIImage(named: "record_animate_02")!,
            UIImage(named: "record_animate_03")!,
            UIImage(named: "record_animate_04")!,
            UIImage(named: "record_animate_05")!,
            UIImage(named: "record_animate_06")!,
            UIImage(named: "record_animate_07")!,
            UIImage(named: "record_animate_08")!,
            UIImage(named: "record_animate_09")!]
        
        imageView = UIImageView(frame: CGRect.zero)
        imageView.image = images[0]
        
        super.init(frame: frame)
        backgroundColor = UIColor(hexString: "365560", alpha: 0.6)
        // 增加毛玻璃效果
        let visualView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        visualView.frame = self.bounds
        visualView.layer.cornerRadius = 10.0
        self.layer.cornerRadius = 10.0
        visualView.layer.masksToBounds = true
        
        addSubview(visualView)
        addSubview(imageView)
        addSubview(textLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: -15))
        
        self.addConstraint(NSLayoutConstraint(item: textLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: textLabel, attribute: .top, relatedBy: .equal, toItem: imageView, attribute: .bottom, multiplier: 1, constant: 10))
        self.addConstraint(NSLayoutConstraint(item: textLabel, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0))
        
        translatesAutoresizingMaskIntoConstraints = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showText(_ text: String, textColor: UIColor = UIColor.black) {
        textLabel.textColor = textColor
        textLabel.text = text
    }
    
    func updateLevelMetra(_ levelMetra: Float) {
        if levelMetra > -20 {
            showMetraLevel(8)
        } else if levelMetra > -25 {
            showMetraLevel(7)
        }else if levelMetra > -30 {
            showMetraLevel(6)
        } else if levelMetra > -35 {
            showMetraLevel(5)
        } else if levelMetra > -40 {
            showMetraLevel(4)
        } else if levelMetra > -45 {
            showMetraLevel(3)
        } else if levelMetra > -50 {
            showMetraLevel(2)
        } else if levelMetra > -55 {
            showMetraLevel(1)
        } else if levelMetra > -60 {
            showMetraLevel(0)
        }
    }
    
    
    func showMetraLevel(_ level: Int) {
        if level > images.count {
            return
        }
        performSelector(onMainThread: #selector(LGRecordIndicatorView.showIndicatorImage(_:)), with: NSNumber(value: level as Int), waitUntilDone: false)
    }
    
    func showIndicatorImage(_ level: NSNumber) {
        imageView.image = images[level.intValue]
    }
    
}
