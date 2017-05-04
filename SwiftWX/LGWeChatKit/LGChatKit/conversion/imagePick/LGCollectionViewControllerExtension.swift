//
//  LGCollectionControllerExtension.swift
//  LGWeChatKit
//
//  Created by jamy on 11/2/15.
//  Copyright © 2015 jamy. All rights reserved.
//


import UIKit
import ObjectiveC


private var selectedIndexPathKey: UInt8 = 101
extension UICollectionViewController {
    var selectedIndexPath: IndexPath?{
        get {
            return objc_getAssociatedObject(self, &selectedIndexPathKey) as? IndexPath
        }
        
        set {
            objc_setAssociatedObject(self, &selectedIndexPathKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}
