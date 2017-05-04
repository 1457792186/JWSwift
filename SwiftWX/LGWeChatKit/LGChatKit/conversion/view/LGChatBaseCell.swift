//
//  LGChatBaseCell.swift
//  LGChatViewController
//
//  Created by jamy on 10/12/15.
//  Copyright © 2015 jamy. All rights reserved.
//

import UIKit

let receiveTag = 0, sendTag = 1
let iconImageTag = 10010, backgroundImageTag = 10020, indicatorTag = 10030

let timeFont = UIFont.systemFont(ofSize: 12.0)
let messageFont = UIFont.systemFont(ofSize: 14.0)
let indicatorFont = UIFont.systemFont(ofSize: 10.0)

class LGChatBaseCell: UITableViewCell {
    
    let iconImageView: UIImageView          // show user icon
    let backgroundImageView: UIImageView    // the cell background view
    let timeLabel: UILabel                  // show timer
    let indicatorView: UIButton             // indicator the message status
    
    var iconContraintNotime: NSLayoutConstraint!
    var iconContraintWithTime: NSLayoutConstraint!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        iconImageView = UIImageView(image: UIImage(named: "DefaultHead"))
        iconImageView.layer.cornerRadius = 8.0
        iconImageView.layer.masksToBounds = true
        iconImageView.tag = iconImageTag
        
        backgroundImageView = UIImageView(image: backgroundImage.incoming, highlightedImage: backgroundImage.incomingHighlighed)
        backgroundImageView.isUserInteractionEnabled = true
        backgroundImageView.layer.cornerRadius = 5.0
        backgroundImageView.layer.masksToBounds = true
        backgroundImageView.tag = backgroundImageTag
        
        timeLabel = UILabel(frame: CGRect.zero)
        timeLabel.textAlignment = .center
        timeLabel.font = timeFont
        
        indicatorView = UIButton(type: .custom)
        indicatorView.tag = indicatorTag
        indicatorView.setBackgroundImage(UIImage(named: "share_auth_fail"), for: UIControlState())
        indicatorView.isHidden = true
        
        indicatorView.setTitleColor(UIColor.black, for: UIControlState())
        indicatorView.titleLabel?.font = indicatorFont
        
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = UIColor.clear
        
        contentView.addSubview(timeLabel)
        contentView.addSubview(iconImageView)
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(indicatorView)
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.translatesAutoresizingMaskIntoConstraints = false

        // add timerLabel constaint, only need add x,y
        contentView.addConstraint(NSLayoutConstraint(item: timeLabel, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: 10))
        contentView.addConstraint(NSLayoutConstraint(item: timeLabel, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: -10))
        contentView.addConstraint(NSLayoutConstraint(item: timeLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 5))
        
        // iconView constraint
        contentView.addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: 10))
        
        iconImageView.addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 45))
        iconImageView.addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 45))
        
        // background constraint
        contentView.addConstraint(NSLayoutConstraint(item: backgroundImageView, attribute: .left, relatedBy: .equal, toItem: iconImageView, attribute: .right, multiplier: 1, constant: 10))
        contentView.addConstraint(NSLayoutConstraint(item: backgroundImageView, attribute: .top, relatedBy: .equal, toItem: iconImageView, attribute: .top, multiplier: 1, constant: 0))
       
        // indicator constraint
        indicatorView.addConstraint(NSLayoutConstraint(item: indicatorView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 17))
        indicatorView.addConstraint(NSLayoutConstraint(item: indicatorView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 17))
        contentView.addConstraint(NSLayoutConstraint(item: indicatorView, attribute: .centerY, relatedBy: .equal, toItem: backgroundImageView, attribute: .centerY, multiplier: 1, constant: -5))
        contentView.addConstraint(NSLayoutConstraint(item: indicatorView, attribute: .left, relatedBy: .equal, toItem: backgroundImageView, attribute: .right, multiplier: 1, constant: 0))
        
        iconContraintNotime = NSLayoutConstraint(item: iconImageView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 10)
        iconContraintWithTime = NSLayoutConstraint(item: iconImageView, attribute: .top, relatedBy: .equal, toItem: timeLabel, attribute: .bottom, multiplier: 1, constant: 5)
    
        contentView.addConstraint(iconContraintWithTime)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        timeLabel.isHidden = false
        contentView.addConstraint(iconContraintWithTime)
    }
    
    func setMessage(_ message: Message) {
        
        if !timeLabel.isHidden {
            contentView.removeConstraint(iconContraintNotime)
            timeLabel.text = message.dataString
        } else {
            contentView.removeConstraint(iconContraintWithTime)
            contentView.addConstraint(iconContraintNotime)
        }
        
        if message.iconName.lengthOfBytes(using: String.Encoding.utf8) > 0 {
            if let image = UIImage(named: message.iconName) {
                iconImageView.image = image
            }
        }
        
        if message.incoming != (tag == receiveTag) {
            var layoutAttribute: NSLayoutAttribute
            var layoutConstraint: CGFloat
            var backlayoutAttribute: NSLayoutAttribute
            
            if message.incoming {
                tag = receiveTag
                backgroundImageView.image = backgroundImage.incoming
                backgroundImageView.highlightedImage = backgroundImage.incomingHighlighed
                layoutAttribute = .left
                backlayoutAttribute = .right
                layoutConstraint = 10
            } else {
                tag = sendTag
                backgroundImageView.image = backgroundImage.outgoing
                backgroundImageView.highlightedImage = backgroundImage.outgoingHighlighed
                layoutAttribute = .right
                backlayoutAttribute = .left
                layoutConstraint = -10
            }
            
            let constraints: NSArray = contentView.constraints as NSArray
            
            // reAdd iconImageView left/right constraint
            let indexOfConstraint = constraints.indexOfObject (passingTest: { (constraint, idx, stop) in
                return (constraint.firstItem ).tag == iconImageTag && (constraint.firstAttribute == NSLayoutAttribute.left || constraint.firstAttribute == NSLayoutAttribute.right)
            })
            contentView.removeConstraint(constraints[indexOfConstraint] as! NSLayoutConstraint)
            contentView.addConstraint(NSLayoutConstraint(item: iconImageView, attribute: layoutAttribute, relatedBy: .equal, toItem: contentView, attribute: layoutAttribute, multiplier: 1, constant: layoutConstraint))
            
            // reAdd backgroundImageView left/right constraint
            let indexOfBackConstraint = constraints.indexOfObject (passingTest: { (constraint, idx, stop) in
                return (constraint.firstItem ).tag == backgroundImageTag && (constraint.firstAttribute == NSLayoutAttribute.left || constraint.firstAttribute == NSLayoutAttribute.right)
            })
            contentView.removeConstraint(constraints[indexOfBackConstraint] as! NSLayoutConstraint)
            contentView.addConstraint(NSLayoutConstraint(item: backgroundImageView, attribute: layoutAttribute, relatedBy: .equal, toItem: iconImageView, attribute: backlayoutAttribute, multiplier: 1, constant: layoutConstraint))
            
            // reAdd indicator left/right constraint
            let indexOfIndicatorConstraint = constraints.indexOfObject (passingTest: { (constraint, idx, stop) in
                return (constraint.firstItem ).tag == indicatorTag && (constraint.firstAttribute == NSLayoutAttribute.left || constraint.firstAttribute == NSLayoutAttribute.right)
            })
            contentView.removeConstraint(constraints[indexOfIndicatorConstraint] as! NSLayoutConstraint)
            contentView.addConstraint(NSLayoutConstraint(item: indicatorView, attribute: layoutAttribute, relatedBy: .equal, toItem: backgroundImageView, attribute: backlayoutAttribute, multiplier: 1, constant: 0))
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        backgroundImageView.isHighlighted = selected
    }
}

let backgroundImage = backgroundImageMake()

func backgroundImageMake() -> (incoming: UIImage, incomingHighlighed: UIImage, outgoing: UIImage, outgoingHighlighed: UIImage) {
    let maskOutgoing = UIImage(named: "SenderTextNodeBkg")!
    let maskOutHightedgoing = UIImage(named: "SenderTextNodeBkgHL")!
    let maskIncoming = UIImage(named: "ReceiverTextNodeBkg")!
    let maskInHightedcoming = UIImage(named: "ReceiverTextNodeBkgHL")!
    
    let incoming = maskIncoming.resizeImage()
    let incomingHighlighted = maskInHightedcoming.resizeImage()
    let outgoing = maskOutgoing.resizeImage()
    let outgoingHighlighted = maskOutHightedgoing.resizeImage()
    
    return (incoming, incomingHighlighted, outgoing, outgoingHighlighted)
}


func imageWithColor(_ image: UIImage, red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIImage! {
    let rect = CGRect(origin: CGPoint.zero, size: image.size)
    UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
    let context = UIGraphicsGetCurrentContext()
    image.draw(in: rect)
    context?.setFillColor(red: red, green: green, blue: blue, alpha: alpha)
    context?.setBlendMode(CGBlendMode.sourceAtop)
    context?.fill(rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage
}

