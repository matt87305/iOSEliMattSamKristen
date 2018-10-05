//
//  AssistantView.swift
//  EliMattSamKristenHackathon
//
//  Created by Matthew Rosemeier on 10/4/18.
//  Copyright © 2018 The Rosetek Group. All rights reserved.
//

import UIKit

protocol AssistantViewDelegate: class {
    func stefonDidFinishFirstHalf()
    func sethDidFinishInterruptionSentence()
}

class AssistantView: UIView {
    
    weak var delegate: AssistantViewDelegate?
    lazy var siri: Siri = {
        let siri = Siri()
        siri.delegate = self
        return siri
    }()
    var isSpeakingStefonFirstHalf = false
    var isSpeakingSethInterruption = false
    
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
        var sentence = ""
        if assistant.name == "Bad Janet" {
            sentence = "Hello! I’m Janet. I’ve just appeared from my limitless void to assist you! After analyzing every thought you’ve ever had, I recommend watching This is Us!"
        } else if assistant.name == "Ron Swanson" {
            sentence = "How many hours have you been on this app? What happened to Americans just going outside and crafting a fine wooden chair or stool. If you cannot be persuaded, I suggest you watch This is Us."
        } else if assistant.name == "Stefon" {
            isSpeakingStefonFirstHalf = true
            sentence = "My name is Stefon and boy do I have a show recommendation for you. Filmed in a Campbell's Chicken Noodle Soup can that posed as nude model for Andy Warhol's famous painting, this eye-gouging, stroke-inducing sequel to Jaws stars Andam Sambler, lovechild of Adam Sandler and Andy Sam"
        } else if assistant.name == "Seth Meyers Special" {
            isSpeakingSethInterruption = true
            sentence = "No Stefon, all we want is a recommendation them to watch. Can you come up with a normal show to suggest?"
        } else if assistant.name == "Stefon Special" {
            sentence = "Ugh, This is Us"
        } else {
            sentence = "Hi there!  My name is \(assistant.name ?? "nothing").  Based on your recent watch history, I think you would enjoy the show, This is Us.  Tap on me, and I'll take you there."
        }
        
        
        siri.speak(sentence, withVoice: assistant.siriType ?? "en-US")
    }
}

extension AssistantView: SiriDelegate {
    func siriDidFinishSpeaking() {
        if isSpeakingStefonFirstHalf {
            isSpeakingStefonFirstHalf = false
            delegate?.stefonDidFinishFirstHalf()
        }
        
        if isSpeakingSethInterruption {
            isSpeakingSethInterruption = false
            delegate?.sethDidFinishInterruptionSentence()
        }
    }
}
