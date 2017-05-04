//
//  LGAssetGridViewController.swift
//  LGChatViewController
//
//  Created by jamy on 10/22/15.
//  Copyright © 2015 jamy. All rights reserved.
//

import UIKit
import Photos

private let reuseIdentifier = "girdCell"
private let itemMargin: CGFloat = 5
private let durationTime = 0.3
private let itemSize: CGFloat = 80

class LGAssetGridViewController: UICollectionViewController, UIViewControllerTransitioningDelegate {
    
    let presentController = LGPresentAnimationController()
    let dismissController = LGDismissAnimationController()
    
    var assetsFetchResults: PHFetchResult<AnyObject>! {
        willSet {
            for i in 0...newValue.count - 1 {
                let asset = newValue[i] as! PHAsset
                let assetModel = LGAssetModel(asset: asset, select: false)
                self.assetModels.append(assetModel)
            }
        }
    }
    
    var toolBar: LGAssetToolView!
    var assetViewCtrl: LGAssetViewController!
    var assetModels = [LGAssetModel]()
    var selectedInfo: NSMutableArray?
    var previousPreRect: CGRect!
    
    lazy var imageManager: PHCachingImageManager = {
            return PHCachingImageManager()
        }()
    
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumInteritemSpacing = itemMargin
        layout.minimumLineSpacing = itemMargin
        layout.sectionInset = UIEdgeInsetsMake(itemMargin, itemMargin, itemMargin, itemMargin)
        super.init(collectionViewLayout: layout)
        self.collectionView?.collectionViewLayout = layout
        collectionView?.contentInset = UIEdgeInsetsMake(0, 0, 50, 0)
    }
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView!.backgroundColor = UIColor.white
        // Register cell classes
        self.collectionView!.register(LGAssertGridViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        previousPreRect = CGRect.zero
        toolBar = LGAssetToolView(leftTitle: "预览", leftSelector: #selector(LGAssetGridViewController.preView), rightSelector: #selector(LGAssetGridViewController.send), parent: self)
        toolBar.frame = CGRect(x: 0, y: view.bounds.height - 50, width: view.bounds.width, height: 50)
        view.addSubview(toolBar)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        toolBar.selectCount = 0
 
        for assetModel in assetModels {
            if assetModel.select {
                toolBar.addSelectCount = 1
            }
        }
        collectionView?.reloadData()
    }
    
    func preView() {
        let assetCtrl = LGAssetViewController()
        assetCtrl.assetModels = assetModels
        self.navigationController?.pushViewController(assetCtrl, animated: true)
    }
    
    func send() {
        navigationController?.viewControllers[0].dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UIViewControllerTransitioningDelegate
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.selectedIndexPath = assetViewCtrl.currentIndex
        return dismissController
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentController
    }
}

extension LGAssetGridViewController {
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return assetModels.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! LGAssertGridViewCell
        
        let asset = assetModels[indexPath.row].asset
        cell.assetModel = assetModels[indexPath.row]
        cell.assetIdentifier = asset.localIdentifier
    
        cell.selectIndicator.tag = indexPath.row
        if assetModels[indexPath.row].select {
            cell.buttonSelect = true
        } else {
            cell.buttonSelect = false
        }
        cell.selectIndicator.addTarget(self, action: #selector(LGAssetGridViewController.selectButton(_:)), for: .touchUpInside)
        
        let scale = UIScreen.main.scale
        imageManager.requestImage(for: asset, targetSize: CGSize(width: itemSize * scale, height: itemSize * scale), contentMode: .aspectFill, options: nil) { (image, _:[AnyHashable: Any]?) -> Void in
            if cell.assetIdentifier == asset.localIdentifier {
                cell.imageView.image = image
            }
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let assetCtrl = LGAssetViewController()
        self.selectedIndexPath = indexPath
        assetCtrl.assetModels = assetModels
        assetCtrl.selectedInfo = selectedInfo
        assetCtrl.selectIndex = indexPath.row
        self.assetViewCtrl = assetCtrl
        let nav = UINavigationController(rootViewController: assetCtrl)
        nav.transitioningDelegate = self
        self.present(nav, animated: true, completion: nil)
    }
    
    // MARK: cell button selector
    
    func selectButton(_ button: UIButton) {
        let assetModel = assetModels[button.tag]
        let cell = collectionView?.cellForItem(at: IndexPath(row: button.tag, section: 0)) as! LGAssertGridViewCell
        if button.isSelected == false {
            assetModel.setSelect(true)
            toolBar.addSelectCount = 1
            button.isSelected = true
            button.addAnimation(durationTime)
            selectedInfo?.add(cell.imageView.image!)
            button.setImage(UIImage(named: "CellBlueSelected"), for: UIControlState())
        } else {
            button.isSelected = false
            assetModel.setSelect(false)
            toolBar.addSelectCount = -1
            selectedInfo?.remove(cell.imageView.image!)
            button.setImage(UIImage(named: "CellGreySelected"), for: UIControlState())
        }
    }
    
    
    // MARK: update chache asset
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateAssetChache()
    }
    
    func updateAssetChache() {
        let isViewVisible = self.isViewLoaded && self.view.window != nil
        if !isViewVisible {
            return
        }
        
        var preRect = (self.collectionView?.bounds)!
        preRect = preRect.insetBy(dx: 0, dy: -0.5 * preRect.height)
        
        let delta = abs(preRect.midY - previousPreRect.midY)
        if delta > (collectionView?.bounds.height)! / 3 {
            var addIndexPaths = [IndexPath]()
            var remoeIndexPaths = [IndexPath]()
            
            differentBetweenRect(previousPreRect, newRect: preRect, removeHandler: { (removeRect) -> Void in
                    remoeIndexPaths.append(contentsOf: self.indexPathInRect(removeRect))
                }, addHandler: { (addRect) -> Void in
                    addIndexPaths.append(contentsOf: self.indexPathInRect(addRect))
            })
            
            imageManager.startCachingImages(for: assetAtIndexPath(addIndexPaths), targetSize: CGSize(width: itemSize, height: itemSize), contentMode: .aspectFill, options: nil)
            imageManager.stopCachingImages(for: assetAtIndexPath(remoeIndexPaths), targetSize: CGSize(width: itemSize, height: itemSize), contentMode: .aspectFill, options: nil)
        }
    }
    
    func assetAtIndexPath(_ indexPaths: [IndexPath]) -> [PHAsset] {
        if indexPaths.count == 0 {
            return []
        }
        var assets = [PHAsset]()
        for indexPath in indexPaths {
            assets.append(assetsFetchResults[indexPath.row] as! PHAsset)
        }
        
        return assets
    }
    
    
    func indexPathInRect(_ rect: CGRect) -> [IndexPath]{
       let allAttributes = collectionView?.collectionViewLayout.layoutAttributesForElements(in: rect)
        if allAttributes?.count == 0 {
            return []
        }
        var indexPaths = [IndexPath]()
        for layoutAttribute in allAttributes! {
            indexPaths.append(layoutAttribute.indexPath)
        }
        
        return indexPaths
    }
    
    func differentBetweenRect(_ oldRect: CGRect, newRect: CGRect, removeHandler: (CGRect)->Void, addHandler:(CGRect)->Void) {
        if newRect.intersects(oldRect) {
            let oldMaxY = oldRect.maxY
            let oldMinY = oldRect.minY
            let newMaxY = newRect.maxY
            let newMinY = newRect.minY
            
            if newMaxY > oldMaxY {
                let rectToAdd = CGRect(x: newRect.x, y: oldMaxY, width: newRect.width, height: newMaxY - oldMaxY)
                addHandler(rectToAdd)
            }
            
            if oldMinY > newMinY {
                let rectToAdd = CGRect(x: newRect.x, y: newMinY, width: newRect.width, height: oldMinY - newMinY)
                addHandler(rectToAdd)
            }
            
            if newMaxY < oldMaxY {
                let rectToMove = CGRect(x: newRect.x, y: newMaxY, width: newRect.width, height: oldMaxY - newMaxY)
                removeHandler(rectToMove)
            }
            
            if oldMinY < newMinY {
                let rectToMove = CGRect(x: newRect.x, y: oldMinY, width: newRect.width, height: newMinY - oldMinY)
                removeHandler(rectToMove)
            }
        } else {
            addHandler(newRect)
            removeHandler(oldRect)
        }
    }
}

