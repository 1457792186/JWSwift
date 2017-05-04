//
//  LGAssetViewModel.swift
//  LGWeChatKit
//
//  Created by jamy on 10/28/15.
//  Copyright © 2015 jamy. All rights reserved.
//

import Foundation
import Photos

class LGAssetViewModel {
    let asset: Observable<PHAsset>
    let image: Observable<UIImage>
    let livePhoto: Observable<PHLivePhoto>
    
    init(assetMode: LGAssetModel) {
        asset = Observable(assetMode.asset)
        image = Observable(UIImage())
        livePhoto = Observable(PHLivePhoto())
    }
    
    func getTargetSize(_ size: CGSize) -> CGSize {
        let scale = UIScreen.main.scale
        let targetSize = CGSize(width: size.width * scale, height: size.height * scale)
        
        return targetSize
    }
    
    
    func updateImage(_ size: CGSize) {
        let haveLivePhotoType = asset.value.mediaSubtypes.rawValue & PHAssetMediaSubtype.photoLive.rawValue
        if haveLivePhotoType == 1 {
            updateLivePhoto(size)
        } else {
            updateStaticImage(size)
        }
    }
    
    
    func updateLivePhoto(_ size: CGSize) {
        let option = PHLivePhotoRequestOptions()
        option.deliveryMode = .highQualityFormat
        option.isNetworkAccessAllowed = true
        
        PHImageManager.default().requestLivePhoto(for: asset.value, targetSize: getTargetSize(size), contentMode: .aspectFit, options: option) { (livephoto, _:[AnyHashable: Any]?) -> Void in
            if let Livephoto = livephoto {
                self.livePhoto.value = Livephoto
            }
        }
    }
    
    func updateStaticImage(_ size: CGSize) {
        let option = PHImageRequestOptions()
        option.deliveryMode = .highQualityFormat
        option.isNetworkAccessAllowed = true
        
        PHImageManager.default().requestImage(for: asset.value, targetSize: getTargetSize(size), contentMode: .aspectFit, options: option) { (image, _: [AnyHashable: Any]?) -> Void in
            if (image == nil) {
                return
            }
            
            self.image.value = image!
        }
    }
}
