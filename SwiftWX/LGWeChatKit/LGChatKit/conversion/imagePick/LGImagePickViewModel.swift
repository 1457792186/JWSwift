//
//  PHRootViewModel.swift
//  LGChatViewController
//
//  Created by jamy on 10/22/15.
//  Copyright © 2015 jamy. All rights reserved.
//

import Foundation
import Photos

class PHRootViewModel {
    let collections: Observable<[PHRootModel]>
    
    init() {
        collections = Observable([])
    }
    
    
    func getCollectionList() {
    
        let albumOptions = PHFetchOptions()
        albumOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        
        let userAlbum = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .albumRegular, options: nil)
        
        userAlbum.enumerateObjects { (collection, index, stop) -> Void in
            let coll = collection as! PHAssetCollection
            let assert = PHAsset.fetchAssets(in: coll, options: nil)
            if assert.count > 0 {
                let model = PHRootModel(title: coll.localizedTitle!, count: assert.count, fetchResult: assert)
                self.collections.value.append(model)
            }
        }
        
        let userCollection = PHCollectionList.fetchTopLevelUserCollections(with: nil)
        
        userCollection.enumerateObjects { (list, index, stop) -> Void in
            let list = list as! PHAssetCollection
            let assert = PHAsset.fetchAssets(in: list, options: nil)
            if assert.count > 0 {
                let model = PHRootModel(title: list.localizedTitle!, count: assert.count, fetchResult: assert)
                self.collections.value.append(model)
            }
        }
        
    }
}
