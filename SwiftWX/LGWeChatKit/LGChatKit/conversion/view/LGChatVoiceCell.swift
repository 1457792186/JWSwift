//
//  LGChatVoiceCell.swift
//  LGChatViewController
//
//  Created by jamy on 10/12/15.
//  Copyright © 2015 jamy. All rights reserved.
//

import UIKit

let voiceIndicatorImageTag = 10040

class LGChatVoiceCell: LGChatBaseCell {

    let voicePlayIndicatorImageView: UIImageView
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        voicePlayIndicatorImageView = UIImageView(frame: CGRect.zero)
        voicePlayIndicatorImageView.tag = voiceIndicatorImageTag
        voicePlayIndicatorImageView.animationDuration = 1.0
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundImageView.addSubview(voicePlayIndicatorImageView)
        
        voicePlayIndicatorImageView.translatesAutoresizingMaskIntoConstraints = false
        
        voicePlayIndicatorImageView.addConstraint(NSLayoutConstraint(item: voicePlayIndicatorImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 12.5))
        voicePlayIndicatorImageView.addConstraint(NSLayoutConstraint(item: voicePlayIndicatorImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 17))
        backgroundImageView.addConstraint(NSLayoutConstraint(item: voicePlayIndicatorImageView, attribute: .left, relatedBy: .equal, toItem: backgroundImageView, attribute: .left, multiplier: 1, constant: 15))
        backgroundImageView.addConstraint(NSLayoutConstraint(item: voicePlayIndicatorImageView, attribute: .centerY, relatedBy: .equal, toItem: backgroundImageView, attribute: .centerY, multiplier: 1, constant: -5))
        contentView.addConstraint(NSLayoutConstraint(item: backgroundImageView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -5))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            voicePlayIndicatorImageView.startAnimating()
        } else {
            voicePlayIndicatorImageView.stopAnimating()
        }
    }
    
    override func setMessage(_ message: Message) {
        super.setMessage(message)
        
        let message = message as! voiceMessage
        setUpVoicePlayIndicatorImageView(!message.incoming)
        
        // hear we can set backgroudImageView's length dure to the voice timer
        let margin = CGFloat(2) * CGFloat(message.voiceTime.int32Value)
        backgroundImageView.addConstraint(NSLayoutConstraint(item: backgroundImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 60 + margin))
        
        indicatorView.isHidden = false
        indicatorView.setBackgroundImage(UIImage.imageWithColor(UIColor.clear), for: UIControlState())

        indicatorView.setTitle("\(message.voiceTime.intValue)\"", for: UIControlState())
        
        var layoutAttribute: NSLayoutAttribute
        var layoutConstant: CGFloat
        if message.incoming {
            layoutAttribute = .left
            layoutConstant = 15
        } else {
            layoutAttribute = .right
            layoutConstant = -15
        }
        
        let constraints: NSArray = backgroundImageView.constraints as NSArray
        
        let indexOfBackConstraint = constraints.indexOfObject (passingTest: { (constraint, idx, stop) in
            return (constraint.firstItem ).tag == voiceIndicatorImageTag && (constraint.firstAttribute == NSLayoutAttribute.left || constraint.firstAttribute == NSLayoutAttribute.right)
        })
        
        backgroundImageView.removeConstraint(constraints[indexOfBackConstraint] as! NSLayoutConstraint)
        backgroundImageView.addConstraint(NSLayoutConstraint(item: voicePlayIndicatorImageView, attribute: layoutAttribute, relatedBy: .equal, toItem: backgroundImageView, attribute: layoutAttribute, multiplier: 1, constant: layoutConstant))
    }
    
    func stopAnimation() {
        if voicePlayIndicatorImageView.isAnimating {
            voicePlayIndicatorImageView.stopAnimating()
        }
    }
    
    
    func beginAnimation() {
        voicePlayIndicatorImageView.startAnimating()
    }
    
    func setUpVoicePlayIndicatorImageView(_ send: Bool) {
        var images = NSArray()
        if send {
            images = NSArray(objects: UIImage(named: "SenderVoiceNodePlaying001")!, UIImage(named: "SenderVoiceNodePlaying002")!, UIImage(named: "SenderVoiceNodePlaying003")!)
            voicePlayIndicatorImageView.image = UIImage(named: "SenderVoiceNodePlaying")
        } else {
            images = NSArray(objects: UIImage(named: "ReceiverVoiceNodePlaying001")!, UIImage(named: "ReceiverVoiceNodePlaying002")!, UIImage(named: "ReceiverVoiceNodePlaying003")!)
            voicePlayIndicatorImageView.image = UIImage(named: "ReceiverVoiceNodePlaying")
        }
        
        voicePlayIndicatorImageView.animationImages = (images as! [UIImage])
    }
    
}
