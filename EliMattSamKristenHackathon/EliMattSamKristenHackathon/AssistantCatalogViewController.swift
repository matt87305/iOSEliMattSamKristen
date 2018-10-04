//
//  AssistantCatalogViewController.swift
//  EliMattSamKristenHackathon
//
//  Created by Matthew Rosemeier on 10/4/18.
//  Copyright © 2018 The Rosetek Group. All rights reserved.
//

import UIKit

protocol AssistantCatalogViewControllerDelegate: class {
    func catalogDidSelect(_ assistant: Assistant)
}

struct Assistant {
    var name: String?
    var showName: String?
    var siriType: String?
    var profileImage: UIImage?
    
    init(_ name: String, _ showName: String, _ siriType: String?, _ profileImage: UIImage) {
        self.name = name
        self.showName = showName
        self.siriType = siriType
        self.profileImage = profileImage
    }
}

class AssistantCatalogViewController: UIViewController {

    weak var delegate: AssistantCatalogViewControllerDelegate?
    
    @IBOutlet fileprivate var collectionView: UICollectionView?
    fileprivate var assistants = [Assistant]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupAssistants()
    }
    
    fileprivate func setupAssistants() {
        assistants = [
            Assistant("Sean Connery", "SNL", "com.apple.ttsbundle.Daniel-compact", #imageLiteral(resourceName: "SeanConnery")),
            Assistant("Leslie Nope", "Parks and Recreation", nil, #imageLiteral(resourceName: "LeslieKnope")),
            Assistant("Ron Swanson", "Parks and Recreation", "com.apple.ttsbundle.Daniel-compact", #imageLiteral(resourceName: "RonSwanson")),
            Assistant("Dwight Shroot", "The Office", "com.apple.ttsbundle.Daniel-compact", #imageLiteral(resourceName: "Dwight")),
            Assistant("Stefon", "SNL", "com.apple.ttsbundle.Daniel-compact", #imageLiteral(resourceName: "Stefon")),
            Assistant("Jimmy Fallon", "The Tonight Show", "com.apple.ttsbundle.Daniel-compact", #imageLiteral(resourceName: "JimmyFallon")),
            Assistant("Blake Shelton", "The Voice", "com.apple.ttsbundle.Daniel-compact", #imageLiteral(resourceName: "Blake")),
            Assistant("Janet", "The Good Place", nil, #imageLiteral(resourceName: "Janet")),
            Assistant("Bad Janet", "The Good Place", nil, #imageLiteral(resourceName: "BadJanet")),
            Assistant("Clippy", "Microsoft Throwback", "com.apple.ttsbundle.Samantha-compact", #imageLiteral(resourceName: "Clippy"))
        ]
    }
    
    @IBAction fileprivate func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
}

extension AssistantCatalogViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let collection = self.collectionView else { return CGSize.zero }
        let collectionViewWith = collection.frame.size.width
        
        return CGSize(width: collectionViewWith/2, height: collectionViewWith/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let assistant = assistants[indexPath.item]
        delegate?.catalogDidSelect(assistant)
        dismissSelf()
    }
}

extension AssistantCatalogViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return assistants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AssistantCollectionViewCell", for: indexPath) as! AssistantCollectionViewCell
        let assistant = assistants[indexPath.item]
        cell.configure(with: assistant)
        return cell
    }
}
