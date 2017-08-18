//
//  ViewController.swift
//  SwiftProteins
//
//  Created by Igor Chemencedji on 8/10/17.
//  Copyright © 2017 Igor Chemencedji. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userPass: UITextField!
    @IBAction func userLogin(_ sender: UIButton) {
        if userName.text == "igor" && userPass.text == "igor" {
            self.navigateToAuthenticatedViewController()
        }
    }
    
    @IBAction func touchID(_ sender: UIButton) {
        var error:NSError?
        let authenticationContext = LAContext()
        guard authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            showAlertViewIfNoBiometricSensorHasBeenDetected()
            return
        }
        authenticationContext.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: "Only awesome people are allowed",
            reply: { [unowned self] (success, error) -> Void in
                if( success ) {
                    
                    // Fingerprint recognized
                    // Go to view controller
                    self.navigateToAuthenticatedViewController()
                    
                }else {
                    print(error!)
                }
        })
    }
    
    func navigateToAuthenticatedViewController(){
        if let loggedInVC = storyboard?.instantiateViewController(withIdentifier: "ListViewController") {
            DispatchQueue.main.async() { () -> Void in
                self.navigationController?.pushViewController(loggedInVC, animated: true)
            }
        }
    }
    
    
    
    func showAlertViewIfNoBiometricSensorHasBeenDetected(){
        showAlertWithTitle(title: "Error", message: "This device does not have a TouchID sensor.")
        
    }
    
    func showAlertWithTitle( title:String, message:String ) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertVC.addAction(okAction)
        DispatchQueue.main.async() { () -> Void in
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

