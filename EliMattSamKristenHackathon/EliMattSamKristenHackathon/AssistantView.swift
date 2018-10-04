//
//  AssistantView.swift
//  EliMattSamKristenHackathon
//
//  Created by Matthew Rosemeier on 10/4/18.
//  Copyright © 2018 The Rosetek Group. All rights reserved.
//

import UIKit

class AssistantView: UIView {
    
    @IBOutlet fileprivate var assistantProfileImageView: UIImageView?

    func configure(with assistant: Assistant) {
        guard let imageView = assistantProfileImageView else { return }
        imageView.image = assistant.profileImage
        imageView.layer.cornerRadius = imageView.frame.size.width * 0.5
        imageView.clipsToBounds = true
        imageView.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        imageView.layer.borderWidth = 5.0
    }
    
    func readMessage(from assistant: Assistant) {
        let siri = Siri()
        var sentence = ""
        if assistant.name == "Bad Janet" {
            sentence = "Hi there, you ding dong!  My name is \(assistant.name ?? "nothing").  Based on your recent watch history, I think you would enjoy the show, This is Us.  Tap on me, and I'll take you there."
        } else {
            sentence = "Hi there!  My name is \(assistant.name ?? "nothing").  Based on your recent watch history, I think you would enjoy the show, This is Us.  Tap on me, and I'll take you there."
        }
        
        
        siri.speak(sentence, withVoice: assistant.siriType ?? "en-US")
    }
}
