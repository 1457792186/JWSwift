//
//  LGAssetToolView.swift
//  LGChatViewController
//
//  Created by jamy on 10/23/15.
//  Copyright © 2015 jamy. All rights reserved.
//

import UIKit

private let buttonWidth = 20
private let durationTime = 0.3

class LGAssetToolView: UIView {
    var preViewButton: UIButton!
    var totalButton: UIButton!
    var sendButton: UIButton!
    weak var parent: UIViewController!
    
    var selectCount = Int() {
        willSet {
            if newValue > 0 {
                totalButton.addAnimation(durationTime)
                totalButton.isHidden = false
                totalButton.setTitle("\(newValue)", for: UIControlState())
            } else {
                totalButton.isHidden = true
            }
        }
    }
    
    var addSelectCount: Int? {
        willSet {
            selectCount += newValue!
        }
    }
    
    convenience init(leftTitle:String, leftSelector: Selector, rightSelector: Selector, parent: UIViewController) {
        self.init()
        self.parent = parent
        
        preViewButton = UIButton(type: .custom)
        preViewButton.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        preViewButton.setTitle(leftTitle, for: UIControlState())
        preViewButton.setTitleColor(UIColor.black, for: UIControlState())
        preViewButton.addTarget(parent, action: leftSelector, for: .touchUpInside)
        
        totalButton = UIButton(type: .custom)
        totalButton.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        totalButton.setBackgroundImage(UIImage.imageWithColor(UIColor.green), for: UIControlState())
        totalButton.layer.cornerRadius = CGFloat(buttonWidth / 2)
        totalButton.layer.masksToBounds = true
        totalButton.isHidden = true
        
        sendButton = UIButton(type: .custom)
        sendButton.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        sendButton.setTitle("发送", for: UIControlState())
        sendButton.setTitleColor(UIColor.gray, for: UIControlState())
        sendButton.addTarget(parent, action: rightSelector, for: .touchUpInside)
        
        backgroundColor = UIColor.groupTableViewBackground
        
        addSubview(preViewButton)
        addSubview(totalButton)
        addSubview(sendButton)
        
        preViewButton.translatesAutoresizingMaskIntoConstraints = false
        totalButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(NSLayoutConstraint(item: preViewButton, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 5))
        addConstraint(NSLayoutConstraint(item: preViewButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: sendButton, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -5))
        addConstraint(NSLayoutConstraint(item: sendButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: totalButton, attribute: .right, relatedBy: .equal, toItem: sendButton, attribute: .left, multiplier: 1, constant: -5))
        addConstraint(NSLayoutConstraint(item: totalButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        totalButton.addConstraint(NSLayoutConstraint(item: totalButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: CGFloat(buttonWidth)))
        totalButton.addConstraint(NSLayoutConstraint(item: totalButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: CGFloat(buttonWidth)))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
