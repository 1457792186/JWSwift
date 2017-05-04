//
//  LGMeViewController.swift
//  LGChatViewController
//
//  Created by jamy on 10/19/15.
//  Copyright © 2015 jamy. All rights reserved.
//

import UIKit
import SafariServices

class LGMeViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我"
        view.backgroundColor = UIColor.groupTableViewBackground
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension LGMeViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            let url = URL(string: "http://weibo.com/u/1805553781")
            let safariCtrl = SFSafariViewController(url: url!)
            safariCtrl.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(safariCtrl, animated: true)
        }
    }
}
