//
//  LGChatVideoCell.swift
//  LGWeChatKit
//
//  Created by jamy on 11/4/15.
//  Copyright © 2015 jamy. All rights reserved.
//

import UIKit
import AVFoundation

class LGChatVideoCell: LGChatBaseCell {

    let videoIndicator: UIImageView
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        videoIndicator = UIImageView()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundImageView.addSubview(videoIndicator)
        
        videoIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundImageView.addConstraint(NSLayoutConstraint(item: backgroundImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 160))
        backgroundImageView.addConstraint(NSLayoutConstraint(item: backgroundImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 120))
        
        contentView.addConstraint(NSLayoutConstraint(item: videoIndicator, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40))
        contentView.addConstraint(NSLayoutConstraint(item: videoIndicator, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40))
        contentView.addConstraint(NSLayoutConstraint(item: videoIndicator, attribute: .centerY, relatedBy: .equal, toItem: backgroundImageView, attribute: .centerY, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: videoIndicator, attribute: .centerX, relatedBy: .equal, toItem: backgroundImageView, attribute: .centerX, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: backgroundImageView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -5))
        
        videoIndicator.image = UIImage(named: "MessageVideoPlay")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setMessage(_ message: Message) {
        super.setMessage(message)
        let message = message as! videoMessage
        let asset = AVAsset(url: message.url as URL)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        do {
            let cgImage = try imageGenerator.copyCGImage(at: CMTimeMake(0, 1), actualTime: nil)
            backgroundImageView.image = UIImage(cgImage: cgImage)
            try! FileManager.default.removeItem(at: message.url as URL)
        } catch let error as NSError {
            NSLog("%@", error)
        }
    }
}
