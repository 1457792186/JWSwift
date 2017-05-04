//
//  LGAssetViewController.swift
//  LGWeChatKit
//
//  Created by jamy on 10/28/15.
//  Copyright © 2015 jamy. All rights reserved.
//

import UIKit
import Photos

private let reuseIdentifier = "assetviewcell"
class LGAssetViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var currentIndex: IndexPath!
    var selectButton: UIButton!
    var playButton: UIBarButtonItem!
    var cellSize: CGSize!
    
    var assetModels = [LGAssetModel]()
    var selectedInfo: NSMutableArray?
    var selectIndex = 0
    
    lazy var imageManager: PHCachingImageManager = {
        return PHCachingImageManager()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        cellSize = (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize
        collectionView.selectItem(at: IndexPath(item: selectIndex, section: 0), animated: false, scrollPosition: .centeredHorizontally)
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.bounds.width, height: view.bounds.height - 64)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.register(LGAssetViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = UIColor.white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavgationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    func setupNavgationBar() {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "CellGreySelected"), for: UIControlState())
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.addTarget(self, action: #selector(LGAssetViewController.selectCurrentImage), for: .touchUpInside)
        let item = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = item
        selectButton = button
        
        let cancelButton = UIBarButtonItem(title: "取消", style: .done, target: self, action: #selector(LGAssetViewController.dismissView))
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    func selectCurrentImage() {
       let indexPaths = collectionView.indexPathsForVisibleItems
       let indexpath = indexPaths.first
        let cell = collectionView.cellForItem(at: indexpath!) as! LGAssetViewCell
        let asset = assetModels[(indexpath?.row)!]
        if asset.select {
            asset.select = false
            selectedInfo?.remove(cell.imageView.image!)
            selectButton.setImage(UIImage(named: "CellGreySelected"), for: UIControlState())
        } else {
            asset.select = true
            selectedInfo?.add(cell.imageView.image!)
            selectButton.setImage(UIImage(named: "CellBlueSelected"), for: UIControlState())
        }
    }
    
    func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - collectionView delegate
extension LGAssetViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return assetModels.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! LGAssetViewCell
      //  cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "imageTapGesture:"))
        let assetModel = assetModels[indexPath.row]
        let viewModel = LGAssetViewModel(assetMode: assetModel)
        viewModel.updateImage(cellSize)
        cell.viewModel = viewModel

        if assetModel.select {
            selectButton.setImage(UIImage(named: "CellBlueSelected"), for: UIControlState())
        } else {
            selectButton.setImage(UIImage(named: "CellGreySelected"), for: UIControlState())
        }
        currentIndex = indexPath
  
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let assetModel = assetModels[indexPath.row]
        let viewModel = LGAssetViewModel(assetMode: assetModel)
        
        let cell = cell as! LGAssetViewCell
        if viewModel.livePhoto.value.size.width != 0 || (viewModel.asset.value.mediaType == .video) {
            cell.stopPlayer()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let assetModel = assetModels[indexPath.row]
        let viewModel = LGAssetViewModel(assetMode: assetModel)
        
        let cell = collectionView.cellForItem(at: indexPath) as! LGAssetViewCell
        if viewModel.livePhoto.value.size.width != 0 || (viewModel.asset.value.mediaType == .video) {
            cell.playLivePhoto()
        } else {
            if UIApplication.shared.isStatusBarHidden == false {
                UIApplication.shared.setStatusBarHidden(true, with: .slide)
                navigationController?.navigationBar.isHidden = true
            } else {
                navigationController?.navigationBar.isHidden = false
                UIApplication.shared.setStatusBarHidden(false, with: .slide)
            }
        }
    }
    
}

// MARK: - scrollView delegate
extension LGAssetViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = Int(collectionView.contentOffset.x / view.bounds.width + 0.5)
        
         self.title = "\(offsetX + 1)" + "/" + "\(assetModels.count)"
        if offsetX >= 0 && offsetX < assetModels.count && selectButton != nil {
            let assetModel = assetModels[offsetX]
            if assetModel.select {
                selectButton.setImage(UIImage(named: "CellBlueSelected"), for: UIControlState())
            } else {
                selectButton.setImage(UIImage(named: "CellGreySelected"), for: UIControlState())
            }
        }
    }
}



