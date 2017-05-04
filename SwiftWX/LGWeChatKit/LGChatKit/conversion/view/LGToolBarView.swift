//
//  LGToolBarView.swift
//  LGChatViewController
//
//  Created by jamy on 10/14/15.
//  Copyright © 2015 jamy. All rights reserved.
//

import UIKit

class LGToolBarView: UIView {

    var textView: UITextView!
    var voiceButton: UIButton!
    var emotionButton: UIButton!
    var moreButton: UIButton!
    var recordButton: UIButton!
    
    convenience init(taget: UIViewController, voiceSelector: Selector, recordSelector: Selector, emotionSelector: Selector, moreSelector: Selector) {
        self.init()
        backgroundColor = UIColor(hexString: "D8EBF2")
        
        voiceButton = UIButton(type: .custom)
        voiceButton.setImage(UIImage(named: "ToolViewInputVoice"), for: UIControlState())
        voiceButton.setImage(UIImage(named: "ToolViewInputVoiceHL"), for: .highlighted)
        voiceButton.addTarget(taget, action: voiceSelector, for: .touchUpInside)
        self.addSubview(voiceButton)
        
        textView = InputTextView()
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.layer.borderColor = UIColor(hexString: "DADADA")?.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 5.0
        textView.scrollsToTop = false
        textView.textContainerInset = UIEdgeInsetsMake(5, 5, 5, 5)
        textView.backgroundColor = UIColor(hexString: "f8fefb")
        textView.returnKeyType = .send
        self.addSubview(textView)
        
        emotionButton = UIButton(type: .custom)
        emotionButton.tag = 1
        emotionButton.setImage(UIImage(named: "ToolViewEmotion"), for: UIControlState())
        emotionButton.setImage(UIImage(named: "ToolViewEmotionHL"), for: .highlighted)
        emotionButton.addTarget(taget, action: emotionSelector, for: .touchUpInside)
        self.addSubview(emotionButton)
        
        moreButton = UIButton(type: .custom)
        moreButton.tag = 2
        moreButton.setImage(UIImage(named: "TypeSelectorBtn_Black"), for: UIControlState())
        moreButton.setImage(UIImage(named: "TypeSelectorBtnHL_Black"), for: .highlighted)
        moreButton.addTarget(taget, action: moreSelector, for: .touchUpInside)
        self.addSubview(moreButton)
        
        recordButton = UIButton(type: .custom)
        recordButton.setTitle("按住     说话", for: UIControlState())
        recordButton.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        recordButton.setBackgroundImage(UIImage.imageWithColor(UIColor(hexString: "F6F6F6")!), for: UIControlState())
        recordButton.setTitleColor(UIColor.black, for: UIControlState())
        recordButton.addTarget(taget, action: recordSelector, for: .touchDown)
        recordButton.layer.borderColor = UIColor(hexString: "DADADA")?.cgColor
        recordButton.layer.borderWidth = 1
        recordButton.layer.cornerRadius = 5.0
        recordButton.layer.masksToBounds = true
        recordButton.isHidden = true
        self.addSubview(recordButton)
        
        voiceButton.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        emotionButton.translatesAutoresizingMaskIntoConstraints = false
        moreButton.translatesAutoresizingMaskIntoConstraints = false
 
        self.addConstraint(NSLayoutConstraint(item: voiceButton, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 5))
        self.addConstraint(NSLayoutConstraint(item: voiceButton, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 5))
        
        self.addConstraint(NSLayoutConstraint(item: textView, attribute: .left, relatedBy: .equal, toItem: voiceButton, attribute: .right, multiplier: 1, constant: 5))
        self.addConstraint(NSLayoutConstraint(item: textView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 5))
        textView.addConstraint(NSLayoutConstraint(item: textView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 35.0))
        self.addConstraint(NSLayoutConstraint(item: textView, attribute: .right, relatedBy: .equal, toItem: emotionButton, attribute: .left, multiplier: 1, constant: -5))
        
        self.addConstraint(NSLayoutConstraint(item: emotionButton, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 5))
        self.addConstraint(NSLayoutConstraint(item: emotionButton, attribute: .right, relatedBy: .equal, toItem: moreButton, attribute: .left, multiplier: 1, constant: -5))
        
        self.addConstraint(NSLayoutConstraint(item: moreButton, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -5))
        self.addConstraint(NSLayoutConstraint(item: moreButton, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 5))
        
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    internal func showRecord(_ show: Bool) {
        if show {
            recordButton.isHidden = false
            recordButton.frame = textView.frame
            textView.isHidden = true
            recordButton.setTitle("按住     说话", for: UIControlState())
            voiceButton.setImage(UIImage(named: "ToolViewKeyboard"), for: UIControlState())
            voiceButton.setImage(UIImage(named: "ToolViewKeyboardHL"), for: .highlighted)
            
            showEmotion(false)
            showMore(false)
        } else {
            recordButton.isHidden = true
            textView.isHidden = false
            textView.inputView = nil
            voiceButton.setImage(UIImage(named: "ToolViewInputVoice"), for: UIControlState())
            voiceButton.setImage(UIImage(named: "ToolViewInputVoiceHL"), for: .highlighted)
        }
    }
    
    
    internal func showEmotion(_ show: Bool) {
        if show {
            emotionButton.tag = 0
            emotionButton.setImage(UIImage(named: "ToolViewKeyboard"), for: UIControlState())
            emotionButton.setImage(UIImage(named: "ToolViewKeyboardHL"), for: .highlighted)
            
            showRecord(false)
            showMore(false)
        } else {
            emotionButton.tag = 1
            textView.inputView = nil
            emotionButton.setImage(UIImage(named: "ToolViewEmotion"), for: UIControlState())
            emotionButton.setImage(UIImage(named: "ToolViewEmotionHL"), for: .highlighted)
        }
    }
    
    internal func showMore(_ show: Bool) {
        if show {
            moreButton.tag = 3
            
            showRecord(false)
            showEmotion(false)
        } else {
            textView.inputView = nil
            moreButton.tag = 2
        }
    }
    
}


// only show copy action when editing textview

class InputTextView: UITextView {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if (delegate as! LGConversationViewController).tableView.indexPathForSelectedRow != nil {
            return action == #selector(InputTextView.copyAction(_:))
        } else {
            return super.canPerformAction(action, withSender: sender)
        }
    }
    
    func copyAction(_ menuController: UIMenuController) {
        (delegate as! LGConversationViewController).copyAction(menuController)
    }
}
