//
//  AssistantCollectionViewCell.swift
//  EliMattSamKristenHackathon
//
//  Created by Matthew Rosemeier on 10/4/18.
//  Copyright © 2018 The Rosetek Group. All rights reserved.
//

import UIKit



public class AssistantCollectionViewCell: UICollectionViewCell {
    @IBOutlet public var assistantNameLabel: UILabel?
    @IBOutlet public var assistantShowNameLabel: UILabel?
    @IBOutlet public var assistantProfileImageView: UIImageView?
    
    func configure(with assistant: Assistant) {
        assistantNameLabel?.text = assistant.name
        assistantShowNameLabel?.text = assistant.showName
        assistantProfileImageView?.image = assistant.profileImage
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if let imageView = assistantProfileImageView {
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = imageView.frame.size.width*0.5
            imageView.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            imageView.layer.borderWidth = 5.0
        }
    }
}
