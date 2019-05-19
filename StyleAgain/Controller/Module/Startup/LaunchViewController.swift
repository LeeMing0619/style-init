//
//  LaunchViewController.swift
//  StyleAgain
//
//  Created by Macmini on 12/2/18.
//  Copyright © 2018 Style Again. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {
    @IBOutlet weak var imgHanger: UIImageView!
    var animating: Bool = true {
        didSet {
            if animating == false {
//                self.imgHanger.transform = .identity
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgHanger.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        imgHanger.layer.anchorPoint = CGPoint(x: 0.5, y: 0.3)
        self.rotateRight()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.animating = false
            self.imgHanger.layer.removeAllAnimations()
            self.showLogin()
        }
        
        DLog(message: "Hello")
    }
    
    func rotateLeft() {
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: { [weak self] in
            self!.imgHanger.transform = CGAffineTransform(rotationAngle: -0.15)
        }) { [weak self] (finished) in
            if let self = self, self.animating {
                self.rotateRight()
            }
        }
    }
    
    func rotateRight() {
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: { [weak self] in
            self?.imgHanger.transform = CGAffineTransform(rotationAngle: 0.15)
        }) { [weak self] (finished) in
            if let self = self, self.animating {
                self.rotateLeft()
            }
        }
    }
    
    func showLogin() {
        if let vc = viewController(forStoryboardName: "Login") {
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func showMain() {
        
    }
}
