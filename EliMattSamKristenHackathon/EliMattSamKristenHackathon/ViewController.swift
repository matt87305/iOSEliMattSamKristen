//
//  ViewController.swift
//  EliMattSamKristenHackathon
//
//  Created by Matthew Rosemeier on 10/4/18.
//  Copyright © 2018 The Rosetek Group. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var currentAssistant = Assistant("Clippy", "Clippy", "com.apple.ttsbundle.Samantha-compact", #imageLiteral(resourceName: "Clippy"))
    var isAssistantVisible = false
    
    @IBOutlet fileprivate var assistantView: AssistantView?
    @IBOutlet fileprivate var assistantViewTrailingConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        hideAssistant(withCompletion: nil)
    }
    
    @IBAction fileprivate func showAssistantAction() {
        if isAssistantVisible {
            hideAssistant(withCompletion: nil)
        } else {
            catalogDidSelect(currentAssistant)
        }
    }

    fileprivate func showAssistant(withCompletion completion:(() -> Void)?) {
        guard let constraint = assistantViewTrailingConstraint else { completion?(); return }
        constraint.constant = 4.0
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            guard let strongSelf = self else { completion?(); return }
            strongSelf.view.layoutIfNeeded()
        }) { [weak self] (complete) in
            guard let strongSelf = self else { completion?(); return }
            completion?()
            strongSelf.isAssistantVisible = true
        }
    }
    
    fileprivate func hideAssistant(withCompletion completion:(() -> Void)?) {
        guard let constraint = assistantViewTrailingConstraint else { completion?(); return }
        constraint.constant = -184.0
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            guard let strongSelf = self else { completion?(); return }
            strongSelf.view.layoutIfNeeded()
        }) { [weak self] (complete) in
            guard let strongSelf = self else { completion?(); return }
            completion?()
            strongSelf.isAssistantVisible = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CatalogModalSegue", let catalogViewController = segue.destination as? AssistantCatalogViewController {
            catalogViewController.delegate = self
        }
    }
}

extension ViewController: AssistantCatalogViewControllerDelegate {
    func catalogDidSelect(_ assistant: Assistant) {
        currentAssistant = assistant
        
        hideAssistant { [weak self] in
            guard let strongSelf = self else { return }
            
            strongSelf.assistantView?.configure(with: assistant)
            strongSelf.showAssistant(withCompletion: {
                strongSelf.assistantView?.readMessage(from: assistant)
            })
        }
    }
}

