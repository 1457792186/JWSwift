//
//  message.swift
//  LGChatViewController
//
//  Created by gujianming on 15/10/12.
//  Copyright © 2015年 jamy. All rights reserved.
//

import Foundation
import UIKit

enum LGMessageType {
    case text
    case voice
    case image
    case video
}

class Message {
    let incoming: Bool
    let sentDate: Date
    var iconName: String
    
    var messageType: LGMessageType {
        get {
            return LGMessageType.text
        }
    }
    let dataString: String = {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let date = Date()
        let formater = DateFormatter()
        formater.dateFormat = "MM-dd HH:mm"
        var dateStr: String = formater.string(from: date)
        return dateStr
    }()
    
    init(incoming: Bool, sentDate: Date, iconName: String) {
        self.incoming = incoming
        self.sentDate = sentDate
        self.iconName = iconName
        // for test
        if incoming {
            self.iconName = "icon1"
        } else {
            self.iconName = "icon3"
        }
    }
}

class textMessage: Message {
    let text: String
    override var messageType: LGMessageType {
        get {
            return LGMessageType.text
        }
    }
    init(incoming: Bool, sentDate: Date, iconName: String, text: String) {
        self.text = text
        super.init(incoming: incoming, sentDate: sentDate, iconName: iconName)
    }
}


class voiceMessage: Message {
    let voicePath: URL
    let voiceTime: NSNumber
    
    override var messageType: LGMessageType {
        get {
            return LGMessageType.voice
        }
    }
    
    init(incoming: Bool, sentDate: Date, iconName: String, voicePath: URL, voiceTime: NSNumber) {
        self.voicePath = voicePath
        self.voiceTime = voiceTime
       super.init(incoming: incoming, sentDate: sentDate, iconName: iconName)
    }
}

class imageMessage: Message {
    let image: UIImage
    override var messageType: LGMessageType {
        get {
            return LGMessageType.image
        }
    }
    
    init(incoming: Bool, sentDate: Date, iconName: String, image: UIImage) {
        self.image = image
        super.init(incoming: incoming, sentDate: sentDate, iconName: iconName)
    }
}


class videoMessage: Message {
    let url: URL
    
    override var messageType: LGMessageType {
        get {
            return LGMessageType.video
        }
    }
    
    init(incoming: Bool, sentDate: Date, iconName: String, url: URL) {
        self.url = url
        super.init(incoming: incoming, sentDate: sentDate, iconName: iconName)
    }
}
