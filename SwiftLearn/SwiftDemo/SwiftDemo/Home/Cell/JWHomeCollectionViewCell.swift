//
//  JWHomeCollectionViewCell.swift
//  SwiftDemo
//
//  Created by apple on 17/5/4.
//  Copyright © 2017年 UgoMedia. All rights reserved.
//

import UIKit

class JWHomeCollectionViewCell: UICollectionViewCell {
    var model:JWHomeDetailModel? = nil;
    
    @IBOutlet weak var showImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setDataModel(dataModel:JWHomeDetailModel){
        model = dataModel;
        self.showImageView?.image = UIImage.init(named: (model?.imageName)!);
    }

}
