//
//  LGAudioPlayer.swift
//  LGChatViewController
//
//  Created by jamy on 10/13/15.
//  Copyright © 2015 jamy. All rights reserved.
//

import UIKit
import AVFoundation

class LGAudioPlayer: NSObject, AVAudioPlayerDelegate {
    
    var audioPlayer: AVAudioPlayer!
    
    override init() {
        
    }
    
    func startPlaying(_ message: voiceMessage) {
        if (audioPlayer != nil && audioPlayer.isPlaying) {
            stopPlaying()
        }
     
        let voiceData = try? Data(contentsOf: message.voicePath as URL)
    
        do {
            try audioPlayer = AVAudioPlayer(data: voiceData!)
        } catch{
            return
        }
        audioPlayer.delegate = self
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        } catch {
            // no-op
        }
        
        audioPlayer.play()
    }
    
    
    func stopPlaying() {
        audioPlayer.stop()
    }
}
