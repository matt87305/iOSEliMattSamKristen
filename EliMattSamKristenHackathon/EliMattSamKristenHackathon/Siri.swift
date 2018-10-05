//
//  Siri.swift
//  EliMattSamKristenHackathon
//
//  Created by Matthew Rosemeier on 10/4/18.
//  Copyright © 2018 The Rosetek Group. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

protocol SiriDelegate: class {
    func siriDidFinishSpeaking()
}

class Siri: NSObject {
    weak var delegate: SiriDelegate?
    
    lazy var speechSynthesizer: AVSpeechSynthesizer = {
        let speechSynthesizer = AVSpeechSynthesizer()
        speechSynthesizer.delegate = self
        return speechSynthesizer
    }()
    
    var isPlaying: Bool {
        return speechSynthesizer.isSpeaking
    }
    
    func speak(_ stringToSpeak: String, withVoice voice: String? = nil) {
        try? AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default)
        let utterance = AVSpeechUtterance(attributedString: NSAttributedString(string: stringToSpeak))
        
        if let voice = voice {
            utterance.voice = AVSpeechSynthesisVoice(identifier: voice)
        }
        
        speechSynthesizer.speak(utterance)
    }
    
    func pause() {
        speechSynthesizer.pauseSpeaking(at: AVSpeechBoundary.word)
    }
    
    func resume() {
        speechSynthesizer.continueSpeaking()
    }
    
    func stop() {
        speechSynthesizer.stopSpeaking(at: .immediate)
    }
}

extension Siri: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        delegate?.siriDidFinishSpeaking()
    }
}
