//
//  LGFriendViewController.swift
//  LGChatViewController
//
//  Created by jamy on 10/19/15.
//  Copyright © 2015 jamy. All rights reserved.
//

import UIKit
import Contacts

class LGFriendViewController: UIViewController {

    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "通讯录"
        view.backgroundColor = UIColor.groupTableViewBackground
        // Do any additional setup after loading the view.
        
        tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        viewModel = FriendViewModel()
        viewModel?.searchContact()
    }

    var viewModel: FriendViewModel? {
        didSet {
            viewModel?.friendSession.observe({ (sessionModel:[contactSessionModel]) -> Void in
                
            })
        }
    }
}


extension LGFriendViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (viewModel?.friendSession.value.count)!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let cellModel = viewModel?.friendSession.value[section]
        return (cellModel?.friends.value.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "friendcell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? LGFriendListCell
        if cell == nil {
            cell = LGFriendListCell(style: .default, reuseIdentifier: cellIdentifier)
            let leftButtons = [UIButton.createButton("修改备注", backGroundColor: UIColor.gray)]
            cell?.setRightButtons(leftButtons)
        }
        let cellModel =  viewModel?.friendSession.value[indexPath.section]
        let friend = cellModel?.friends.value[indexPath.row]
        
        cell?.viewModel = friend
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let cellModel =  viewModel?.friendSession.value[section]
        return cellModel?.key.value
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        var titles = [String]()
        for i in 65...90 {
            let title = NSString(format: "%c", i)
            titles.append(title as String)
        }
        return titles
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        for i in 0..<viewModel!.friendSession.value.count {
            if viewModel?.friendSession.value[i].key.value == title {
                return i
            }
        }
        return 1
    }
    
}
