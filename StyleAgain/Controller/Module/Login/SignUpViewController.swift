//
//  SignUpViewController.swift
//  StyleAgain
//
//  Created by Macmini on 12/2/18.
//  Copyright © 2018 Style Again. All rights reserved.
//

import UIKit

class SignUpViewController: BaseViewController {
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func onSignUp(_ sender: Any) {
        UIManager.shared.showWalkThrough(controller: self)
    }    
}
