//
//  LGChatMessageCell.swift
//  LGChatViewController
//
//  Created by jamy on 10/11/15.
//  Copyright © 2015 jamy. All rights reserved.
//

import UIKit

class LGChatTextCell: LGChatBaseCell {

    let messageLabel: UILabel
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    
        messageLabel = UILabel(frame: CGRect.zero)
        messageLabel.isUserInteractionEnabled = false
        messageLabel.numberOfLines = 0
        messageLabel.font = messageFont
        
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none

        backgroundImageView.addSubview(messageLabel)
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundImageView.addConstraint(NSLayoutConstraint(item: backgroundImageView, attribute: .width, relatedBy: .equal, toItem: messageLabel, attribute: .width, multiplier: 1, constant: 30))
        backgroundImageView.addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .centerX, relatedBy: .equal, toItem: backgroundImageView, attribute: .centerX, multiplier: 1, constant: 0))
        backgroundImageView.addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .centerY, relatedBy: .equal, toItem: backgroundImageView, attribute: .centerY, multiplier: 1, constant: -5))
        messageLabel.preferredMaxLayoutWidth = 210
        backgroundImageView.addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .height, relatedBy: .equal, toItem: backgroundImageView, attribute: .height, multiplier: 1, constant: -30))
        contentView.addConstraint(NSLayoutConstraint(item: backgroundImageView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -5))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setMessage(_ message: Message) {
        super.setMessage(message)
        let message = message as! textMessage
        messageLabel.text = message.text

        //indicatorView.hidden = false
        if message.incoming != (tag == receiveTag) {
            
            if message.incoming {
                tag = receiveTag
                backgroundImageView.image = backgroundImage.incoming
                backgroundImageView.highlightedImage = backgroundImage.incomingHighlighed
                messageLabel.textColor = UIColor.black
            } else {
                tag = sendTag
                backgroundImageView.image = backgroundImage.outgoing
                backgroundImageView.highlightedImage = backgroundImage.outgoingHighlighed
                messageLabel.textColor = UIColor.white
            }
            
            let messageConstraint : NSLayoutConstraint = backgroundImageView.constraints[1]
            messageConstraint.constant = -messageConstraint.constant
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        backgroundImageView.isHighlighted = selected
    }
}

