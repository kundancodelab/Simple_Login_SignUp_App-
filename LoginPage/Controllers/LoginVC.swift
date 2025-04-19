//
//  LoginVC.swift
//  LoginPage
//
//  Created by Kundan ios dev  on 20/07/24.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class LoginVC: UIViewController {

    @IBOutlet weak var logInButton: UIButton!
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var mobileNumberTextField: UITextField!
    var userimage:UIImage!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        mobileNumberTextField.delegate = self
     
        // Do any additional setup after loading the view.
        settextField(mobileNumberTextField)
        
        setTextFieldColor(mobileNumberTextField, mobileNumberTextField.placeholder ?? "")
       
        if let userimage = userimage {
            userImage.image = userimage
        }
        logInButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    @objc func loginButtonTapped() {
           // Perform the shake animation
           let shakeAnimation = CABasicAnimation(keyPath: "position")
           shakeAnimation.duration = 0.1
           shakeAnimation.repeatCount = 2
           shakeAnimation.autoreverses = true
           let fromPoint = CGPoint(x: logInButton.center.x - 10, y: logInButton.center.y)
           let toPoint = CGPoint(x: logInButton.center.x + 10, y: logInButton.center.y)
           shakeAnimation.fromValue = NSValue(cgPoint: fromPoint)
           shakeAnimation.toValue = NSValue(cgPoint: toPoint)
           
           logInButton.layer.add(shakeAnimation, forKey: "position")
           
           // Perform your login logic here
       }
    func settextField(_ textfield:UITextField){
        textfield.layer.cornerRadius = 20
        textfield.clipsToBounds = true 
    }
    
    
    @IBAction func logInButtonPressed(_ sender: UIButton) {
        
        guard  let mobileNumber = mobileNumberTextField.text , !mobileNumber.isEmpty else {
            alertDisplay(titleMsg: "", displayMessage: "Mobile number can't be empty", buttonLabel:"dismiss")
            return
        }
        if isValidPhone(phone: mobileNumber) {
             // Mobile number is correct. 
        }else {
            alertDisplay(titleMsg: "", displayMessage: "Invalid Mobile number", buttonLabel: "Ok")
            return
        }
       
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "OTPViewController") as? OTPViewController {
            vc.phoneNumber = mobileNumber
        }
      
        
    }
    
    
    
    @IBAction func signUpButtonPressedFromLoginVC(_ sender: UIButton) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVCViewController") as? SignUpVCViewController
        {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    
    @IBAction func sentOTPButonPressed(_ sender: UIButton) {
        guard  let phone = mobileNumberTextField.text , !phone.isEmpty else {
            alertDisplay(titleMsg: "", displayMessage: "Mobile Number can't be empty ", buttonLabel: "Ok")
            return
        }
        AuthManager.shared.sendingOTP(phone){ success in
            if success {
                DispatchQueue.main.async {
                    if let vc = self.storyboard?.instantiateViewController(withIdentifier: "OTPViewController") as? OTPViewController {
                        vc.phoneNumber = phone
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    }
                }
               
            }
            
        }
       
    }
    
    
    @IBAction func goBackButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
}

// MARK: - TextfieldDelegate

extension LoginVC:UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        
    
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}
