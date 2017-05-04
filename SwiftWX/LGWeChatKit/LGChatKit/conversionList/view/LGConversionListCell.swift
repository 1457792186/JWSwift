//
//  LGConversionListCell.swift
//  LGChatViewController
//
//  Created by jamy on 10/19/15.
//  Copyright © 2015 jamy. All rights reserved.
//

import UIKit

class LGConversionListCell: LGConversionListBaseCell {

    let iconView: UIImageView!
    let userNameLabel: UILabel!
    let messageLabel: UILabel!
    let timerLabel: UILabel!
    
    let messageListCellHeight = 64
    
    
    var viewModel: LGConversionListCellModel? {
        didSet {
            viewModel?.iconName.observe {
                [unowned self] in
                self.iconView.image = UIImage(named: $0)
            }
            
            viewModel?.lastMessage.observe {
                [unowned self] in
                self.messageLabel.text = $0
            }
            
            viewModel?.userName.observe {
                [unowned self] in
                self.userNameLabel.text = $0
            }
            
            viewModel?.timer.observe {
                [unowned self] in
                self.timerLabel.text = $0
            }
        }
    }
    

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        iconView = UIImageView(frame: CGRect(x: 5, y: CGFloat(messageListCellHeight - 50) / 2, width: 50, height: 50))
        iconView.layer.cornerRadius = 5.0
        iconView.layer.masksToBounds = true
        
        userNameLabel = UILabel()
        userNameLabel.textAlignment = .left
        userNameLabel.font = UIFont.systemFont(ofSize: 14.0)
        
        messageLabel = UILabel()
        messageLabel.textAlignment = .left
        messageLabel.font = UIFont.systemFont(ofSize: 13.0)
        messageLabel.textColor = UIColor.lightGray
        
        timerLabel = UILabel()
        timerLabel.textAlignment = .right
        timerLabel.font = UIFont.systemFont(ofSize: 14.0)
        timerLabel.textColor = UIColor.lightGray
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(iconView)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(messageLabel)
        contentView.addSubview(timerLabel)
        
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addConstraint(NSLayoutConstraint(item: userNameLabel, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: CGFloat(messageListCellHeight + 8)))
        contentView.addConstraint(NSLayoutConstraint(item: userNameLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 5))
        
        contentView.addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .left, relatedBy: .equal, toItem: userNameLabel, attribute: .left, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .top, relatedBy: .equal, toItem: userNameLabel, attribute: .bottom, multiplier: 1, constant: 10))
        contentView.addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: -70))
        
        contentView.addConstraint(NSLayoutConstraint(item: timerLabel, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: -65))
        contentView.addConstraint(NSLayoutConstraint(item: timerLabel, attribute: .top, relatedBy: .equal, toItem: userNameLabel, attribute: .top, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: timerLabel, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: -5))
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
