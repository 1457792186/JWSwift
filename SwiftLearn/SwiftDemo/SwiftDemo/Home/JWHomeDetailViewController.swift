//
//  JWHomeDetailViewController.swift
//  SwiftDemo
//
//  Created by apple on 17/5/4.
//  Copyright © 2017年 UgoMedia. All rights reserved.
//

import UIKit

class JWHomeDetailViewController: JWBasicViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    @objc var dataModel:JWHomeDetailsModel? = nil;
    
    @IBOutlet weak var detailCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "列表";
        self.registerCollectionView();
    }
    
    @objc func registerCollectionView(){
        let collectionNib = UINib.init(nibName: "JWHomeCollectionViewCell", bundle: nil);
        
        self.detailCollectionView.register(collectionNib, forCellWithReuseIdentifier: "JWHomeCollectionViewCell");
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return (dataModel?.content.count)!;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let detailCell:JWHomeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "JWHomeCollectionViewCell", for: indexPath) as! JWHomeCollectionViewCell;
        let model:JWHomeDetailModel = dataModel?.content[indexPath.row] as! JWHomeDetailModel;
        detailCell.setDataModel(dataModel: model);
        return detailCell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let model:JWHomeDetailModel = dataModel?.content[indexPath.row] as! JWHomeDetailModel;
        JWTools.showHud(hudStr: model.title);
    }
    
    // MARK: - UICollectionViewFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let width = (mainScreenWidth - 15)/2;
        let height = 80 * (mainScreenWidth - 15) / 360;
        
        return CGSize.init(width: width, height: height);
    }

}
