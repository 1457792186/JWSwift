//
//  LGAssertGridViewCell.swift
//  LGChatViewController
//
//  Created by jamy on 10/22/15.
//  Copyright © 2015 jamy. All rights reserved.
//

import UIKit

class LGAssertGridViewCell: UICollectionViewCell {
    
    let buttonWidth: CGFloat = 30
    var assetIdentifier: String!
    var imageView:UIImageView!
    var playIndicator: UIImageView?
    var selectIndicator: UIButton
    var assetModel: LGAssetModel! {
        didSet {
            if assetModel.asset.mediaType == .video {
                self.playIndicator?.isHidden = false
            } else {
                self.playIndicator?.isHidden = true
            }
        }
    }
    var buttonSelect: Bool {
        willSet {
            if newValue {
                selectIndicator.isSelected = true
                selectIndicator.setImage(UIImage(named: "CellBlueSelected"), for: UIControlState())
            } else {
                selectIndicator.isSelected = false
                selectIndicator.setImage(UIImage(named: "CellGreySelected"), for: UIControlState())
            }
        }
    }
    
    override init(frame: CGRect) {
        selectIndicator = UIButton(type: .custom)
        selectIndicator.tag = 1

        buttonSelect = false
        super.init(frame: frame)
        imageView = UIImageView(frame: bounds)
        //imageView.contentMode = .ScaleAspectFit
        contentView.addSubview(imageView)
        
        playIndicator = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        playIndicator?.center = contentView.center
        playIndicator?.image = UIImage(named: "mmplayer_idle")
        contentView.addSubview(playIndicator!)
        playIndicator?.isHidden = true
        
        selectIndicator.frame = CGRect(x: bounds.width - buttonWidth , y: 0, width: buttonWidth, height: buttonWidth)
        contentView.addSubview(selectIndicator)
        selectIndicator.setImage(UIImage(named: "CellGreySelected"), for: UIControlState())
        
        backgroundColor = UIColor.white
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let durationTime = 0.3
    
    func selectButton(_ button: UIButton) {
        if button.tag == 1 {
            button.tag = 0
            let groupAnimation = CAAnimationGroup()
    
            let animationZoomOut = CABasicAnimation(keyPath: "transform.scale")
            animationZoomOut.fromValue = 0
            animationZoomOut.toValue = 1.2
            animationZoomOut.duration = 3/4 * durationTime
            
            let animationZoomIn = CABasicAnimation(keyPath: "transform.scale")
            animationZoomIn.fromValue = 1.2
            animationZoomIn.toValue = 1.0
            animationZoomIn.beginTime = 3/4 * durationTime
            animationZoomIn.duration = 1/4 * durationTime
            
            groupAnimation.animations = [animationZoomOut, animationZoomIn]
            buttonSelect = true
            assetModel.select = true
            selectIndicator.layer.add(groupAnimation, forKey: "selectZoom")
        } else {
            button.tag = 1
            buttonSelect = false
            assetModel.select = false
        }
    }
}
