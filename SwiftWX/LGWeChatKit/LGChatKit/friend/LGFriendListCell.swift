//
//  LGFriendListCecll.swift
//  LGChatViewController
//
//  Created by jamy on 10/20/15.
//  Copyright © 2015 jamy. All rights reserved.
//

import UIKit

class LGFriendListCell: LGConversionListBaseCell {

    let iconView: UIImageView!
    let userNameLabel: UILabel!
    let phoneLabel: UILabel!

    let messageListCellHeight = 44
    let imageHeight = 40
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        iconView = UIImageView(frame: CGRect(x: 5, y: CGFloat(messageListCellHeight - imageHeight) / 2, width: CGFloat(imageHeight), height: CGFloat(imageHeight)))
        iconView.layer.cornerRadius = 5.0
        iconView.layer.masksToBounds = true
        
        userNameLabel = UILabel()
        userNameLabel.textAlignment = .left
        userNameLabel.font = UIFont.systemFont(ofSize: 14.0)
        
        phoneLabel = UILabel()
        phoneLabel.textAlignment = .left
        phoneLabel.font = UIFont.systemFont(ofSize: 13.0)
        phoneLabel.textColor = UIColor.lightGray
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(iconView)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(phoneLabel)
        
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addConstraint(NSLayoutConstraint(item: userNameLabel, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: CGFloat(messageListCellHeight + 8)))
        contentView.addConstraint(NSLayoutConstraint(item: userNameLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 5))
        
        contentView.addConstraint(NSLayoutConstraint(item: phoneLabel, attribute: .left, relatedBy: .equal, toItem: userNameLabel, attribute: .left, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: phoneLabel, attribute: .top, relatedBy: .equal, toItem: userNameLabel, attribute: .bottom, multiplier: 1, constant: 5))
        contentView.addConstraint(NSLayoutConstraint(item: phoneLabel, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: -70))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var viewModel: contactCellModel? {
        didSet {
            viewModel?.iconName.observe {
                [unowned self] in
                self.iconView.image = UIImage(named: $0)
            }
            
            viewModel?.name.observe {
                [unowned self] in
                self.userNameLabel.text = $0
            }
            
            viewModel?.phone.observe {
                [unowned self] in
                self.phoneLabel.text = $0
            }
        }
    }
    
}
