//
//  LGFindViewController.swift
//  LGChatViewController
//
//  Created by jamy on 10/19/15.
//  Copyright © 2015 jamy. All rights reserved.
//

import UIKit
import CoreSpotlight
import MobileCoreServices


let uniqueIdentifier = "com.jamy.wechat"
let domainIdentifier = "jamy"

class LGFindViewController: UITableViewController {
    
    var activity: NSUserActivity!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "发现"
        view.backgroundColor = UIColor.groupTableViewBackground
        // Do any additional setup after loading the view.
        
        let activityType = String(format: "%@.%@", uniqueIdentifier, domainIdentifier)
        activity = NSUserActivity(activityType: activityType)
        activity.title = "jamy-search"
        activity.keywords = Set<String>(arrayLiteral: "微信", "jamy", "MJ")
        activity.isEligibleForSearch = true
        activity.becomeCurrent()
        
        // core spotlight
        let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeImage as String)
        attributeSet.title = "jamy-spotlight search"
        attributeSet.contentDescription = "jamy写的仿微信界面，谢谢大家支持"
        attributeSet.keywords = ["微信", "jamy", "MJ"]
        let image = UIImage(named: "icon")
        let data = UIImagePNGRepresentation(image!)
        attributeSet.thumbnailData = data
        
        let searchItem = CSSearchableItem(uniqueIdentifier: uniqueIdentifier, domainIdentifier: domainIdentifier, attributeSet: attributeSet)
        
        CSSearchableIndex.default().indexSearchableItems([searchItem]) { (error) -> Void in
            if error != nil {
                NSLog("search fail")
            } else {
                NSLog("search success")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if indexPath.section == 1 && indexPath.row == 0 {
            if TARGET_OS_SIMULATOR == 1 {
                showAlterView()
                return
            } else {
                self.navigationController?.pushViewController(LGScanViewController(), animated: true)
            }
        }
    }
    
    func showAlterView() {
        let alter = UIAlertController(title: "Tip", message: "Simulator can't use this function!", preferredStyle: .alert)
        alter.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: { (action) -> Void in
            self.dismiss(animated: true, completion: nil)
        }))
        
        present(alter, animated: true, completion: nil)
    }
}
