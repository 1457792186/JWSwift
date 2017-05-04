//
//  LGImagePickController.swift
//  LGChatViewController
//
//  Created by jamy on 10/21/15.
//  Copyright © 2015 jamy. All rights reserved.
//

import UIKit
import Photos
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l >= r
  default:
    return !(lhs < rhs)
  }
}



protocol LGImagePickControllerDelegate {
     func imagePickerController(_ picker: LGImagePickController, didFinishPickingImages images: [UIImage])
     func imagePickerControllerCanceled(_ picker: LGImagePickController)
}

class LGImagePickController: UITableViewController {

    var delegate: LGImagePickControllerDelegate?
    var viewModel: PHRootViewModel?
    var selectedInfo = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = PHRootViewModel()
        
        // hidden no used cell
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        PHPhotoLibrary.requestAuthorization { (authorizationStatus) -> Void  in
            if authorizationStatus == .authorized {
                self.viewModel?.getCollectionList()
                DispatchQueue.main.async(execute: { () -> Void in
                    self.tableView.reloadData()
                })
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let item = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(LGImagePickController.dismissView))
        self.navigationItem.rightBarButtonItem = item
        
        selectedInfo.removeAllObjects()
    }
    
    func dismissView() {
        delegate?.imagePickerControllerCanceled(self)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)?) {
        super.dismiss(animated: flag, completion: completion)

        delegate?.imagePickerController(self, didFinishPickingImages: selectedInfo.copy() as! [UIImage])
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.viewModel?.collections.value.count)!
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "ImagePickreuseIdentifier")

        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "ImagePickreuseIdentifier")
            cell?.imageView?.contentMode = .scaleToFill
            cell?.accessoryType = .disclosureIndicator
        }
        let collection = viewModel?.collections.value[indexPath.row]
        PHImageManager.default().requestImage(for: collection?.fetchResult.lastObject as! PHAsset, targetSize: CGSize(width: 50, height: 60), contentMode: .aspectFit, options: nil) { (image, _: [AnyHashable: Any]?) -> Void in
            if image == nil {
                return
            }
            cell?.imageView?.image = image
            self.tableView.reloadData()
        }

        cell?.textLabel?.text = collection?.title
        cell?.detailTextLabel?.text = String("\(collection!.count)")
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fetchReslut = viewModel?.collections.value[indexPath.row]
        
        let gridCtrl = LGAssetGridViewController()
        gridCtrl.assetsFetchResults = fetchReslut?.fetchResult
        gridCtrl.selectedInfo = selectedInfo
        gridCtrl.title = fetchReslut?.title
        self.navigationController?.pushViewController(gridCtrl, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row >= viewModel?.collections.value.count {
            return 100
        } else {
            return CGFloat(75)
        }
    }
}
