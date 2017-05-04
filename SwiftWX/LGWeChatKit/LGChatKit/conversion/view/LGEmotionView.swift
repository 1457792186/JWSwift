//
//  LGEmotionView.swift
//  LGChatViewController
//
//  Created by jamy on 10/15/15.
//  Copyright © 2015 jamy. All rights reserved.
//

import UIKit

protocol LGEmotionViewDelegate {
    func selectEmoji(_ code: String, description: String, delete: Bool)
}


class LGEmotionView: UIView , UIScrollViewDelegate{
    var scrollView: UIScrollView!
    var pageCtrl: UIPageControl!
   
    var delegate: LGEmotionViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(hexString: "F6F6F8")
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height - 30))
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        pageCtrl = UIPageControl(frame: CGRect(x: 0, y: scrollView.frame.height, width: bounds.width, height: 30))
        pageCtrl.pageIndicatorTintColor = UIColor.groupTableViewBackground
        pageCtrl.currentPageIndicatorTintColor = UIColor.lightGray
        
        addSubview(scrollView)
        addSubview(pageCtrl)
        
        let emojiCount = LGEmotionManager.shareInstance.emotionArray.count
        let pageCount = emojiCount % 23 == 0 ? emojiCount / 23 : emojiCount / 23 + 1
        
        scrollView.contentSize = CGSize(width: bounds.width * CGFloat(pageCount), height: bounds.height - 30)
        pageCtrl.numberOfPages = pageCount
        pageCtrl.currentPage = 0
        
        for i in 0...pageCount-1 {
            let emojiView = LGEmojiView(frame: CGRect(x: CGFloat(i) * bounds.width, y: 0, width: bounds.width, height: bounds.height - 30), index: i, parentView: self, selector: #selector(LGEmotionView.emojiClick(_:)))
            scrollView.addSubview(emojiView)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func emojiClick(_ button: UIButton) {
        var emojiCode: String!
        var emojiDescription: String!
        var delete: Bool = false
        
        if button.tag == 0 {
            emojiCode = ""
            emojiDescription = ""
            delete = true
        } else {
            let currentEmoji = LGEmotionManager.shareInstance.emotionArray[button.tag - 1] as! NSArray
            emojiCode = currentEmoji[0] as! String
            emojiDescription = currentEmoji[2] as! String
            delete = false
        }
        
        delegate?.selectEmoji(emojiCode, description: emojiDescription, delete: delete)
    }
    

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x / bounds.width
        if offset > 0.5 {
            pageCtrl.currentPage = Int(offset + 0.5)
        } else {
            pageCtrl.currentPage = Int(offset)
        }
    }
}


class LGEmojiView: UIView {
    let numberPerLine = 8       // number of per line
    let line = 3                // line count in page
    let buttonH = 24            // button width
    let horizontalEdge = 30     // horizonal Edge
    let verticalEdge = 20       // vertical Edge
    
    var parent: LGEmotionView!
    var buttonSelector: Selector!
    
    convenience init(frame: CGRect,index: Int, parentView: LGEmotionView, selector: Selector) {
        self.init(frame: frame)
        parent = parentView
        buttonSelector = selector
        setupEmotionWith(index)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    func setupEmotionWith(_ index: Int) {
        
        let emotionCount = LGEmotionManager.shareInstance.emotionArray.count
        let horizontalMargin = (bounds.width - CGFloat(numberPerLine * buttonH) - CGFloat(2 * horizontalEdge)) / CGFloat(numberPerLine - 1)
       
        for i in 0...line-1 {
            for j in 0...numberPerLine-1 {
                let emotionIndex = (index * 23) + i * numberPerLine + j + 1
                
                if emotionIndex <= emotionCount + 1 {
                    let button = UIButton(type: .custom)
                    addSubview(button)
                    button.addTarget(parent, action: #selector(LGEmotionView.emojiClick(_:)), for: .touchUpInside)
                    button.frame = CGRect(x: CGFloat(j * buttonH) + CGFloat(horizontalEdge) + CGFloat(j) * horizontalMargin,
                        y: CGFloat(i * buttonH) + CGFloat(verticalEdge) + CGFloat(i) * CGFloat(verticalEdge),
                        width: CGFloat(buttonH),
                        height: CGFloat(buttonH))
                    
                    if i * numberPerLine + j + 1 == numberPerLine * line || emotionIndex == emotionCount + 1{
                        button.frame = CGRect(x: button.frame.x, y: button.frame.y, width: 30, height: 30)
                        button.setBackgroundImage(UIImage(named: "DeleteEmoticonBtn"), for: UIControlState())
                        button.tag = 0
                    } else {
                        button.setBackgroundImage(UIImage(named: "Expression_" + "\(emotionIndex)"), for: UIControlState())
                        button.tag = emotionIndex
                    }
                }
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



