//
//  FriendViewModel.swift
//  LGChatViewController
//
//  Created by jamy on 10/20/15.
//  Copyright © 2015 jamy. All rights reserved.
//

import Foundation
import Contacts

@available(iOS 9.0, *)
class FriendViewModel {
    let friendSession: Observable<[contactSessionModel]>
    
    init () {
        friendSession = Observable([])
    }
    
    func searchContact() {
        let store = CNContactStore()
        let keyToFetch = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName), CNContactImageDataKey, CNContactPhoneNumbersKey] as [Any]
        let fetchRequest = CNContactFetchRequest(keysToFetch: keyToFetch as! [CNKeyDescriptor])
        
        var contacts = [CNContact]()
        
        do {
            try store.enumerateContacts(with: fetchRequest, usingBlock: { (contact, stop) -> Void in
                contacts.append(contact)
            })
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        update(contacts)
    }
    
    let image = ["icon1", "icon2", "icon3", "icon4", "icon0"]
    
    fileprivate func update(_ contacts: [CNContact]) {
        var phonenumber = ""
        var name = ""
        var iconname = ""
        
        for contact in contacts {
            
            name = "\(contact.familyName)\(contact.givenName)"
            iconname = image[random() % 5]
            
            for number in contact.phoneNumbers {
                let phoneNumber = number.value 
                if phoneNumber.stringValue.lengthOfBytes(using: String.Encoding.utf8) > 0 {
                    phonenumber = phoneNumber.stringValue
                    break
                }
            }
            let friend = Friend(name: name, phone: phonenumber, iconName: iconname)
            addToSession(friend)
        }
    }
    
    
    fileprivate func addToSession(_ friend: Friend) {
        var newSession = true
        var englishName = change2English(friend.name)
        if englishName.lengthOfBytes(using: String.Encoding.utf8) < 1 {
            englishName = "*"
        }
        let firstChar = englishName.substring(to: englishName.characters.index(englishName.startIndex, offsetBy: 1))
        
        for session in friendSession.value {
            if session.key.value == firstChar {
                newSession = false
                session.friends.value.append(contactCellModel(friend))
                break
            }
        }
        
        if newSession  {
            let newContactSession = contactSessionModel()
            newContactSession.key.value = firstChar
            newContactSession.friends.value = [contactCellModel(friend)]
            friendSession.value.append(newContactSession)
        }
        
    }

    // change to english
    fileprivate func change2English(_ chinese: String) -> String {
        let mutableString = NSMutableString(string: chinese) as CFMutableString
        CFStringTransform(mutableString, UnsafeMutablePointer<CFRange>(nil), kCFStringTransformMandarinLatin, false)
        CFStringTransform(mutableString, UnsafeMutablePointer<CFRange>(nil), kCFStringTransformStripDiacritics, false)
        
        return mutableString as String
    }

}
