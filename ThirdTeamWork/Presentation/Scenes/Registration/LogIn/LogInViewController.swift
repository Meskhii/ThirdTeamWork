//
//  LogInViewController.swift
//  ThirdTeamWork
//
//  Created by CodergirlTM on 08.07.21.
//

import UIKit

class LogInViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logInBtn(_ sender: Any) {
    }

     @IBAction func signUpBtn(_ sender: Any) {
        coordinator?.navigateToSignUpPage()
     }
    

}
