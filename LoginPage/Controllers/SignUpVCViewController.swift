//
//  ViewController.swift
//  LoginPage
//
//  Created by Kundan ios dev  on 20/07/24.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import AEOTPTextField

class SignUpVCViewController: UIViewController {

    
    @IBOutlet weak var uiView: UIView!
    
    @IBOutlet weak var logButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var userimage: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var DOBTextField: UITextField!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    let datePicker = UIDatePicker()
    override func viewDidLoad() {
       // OTPTextField.delegate = self
        super.viewDidLoad()
        setUptextField(usernameTextField)
        setUptextField(mobileNumberTextField)
        setUptextField(DOBTextField)
        uiView.setUPUiView(uiView)
        self.setTextFieldColor(usernameTextField, usernameTextField.placeholder ?? "")
        self.setTextFieldColor(mobileNumberTextField, mobileNumberTextField.placeholder ?? "")
        self.setTextFieldColor(DOBTextField, DOBTextField.placeholder ?? "")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        userimage.addGestureRecognizer(tapGesture)
        signUpButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        setupDatePicker()
    }
    // VerifyPhone Button is clicked to go on OTPVerification viewController to verify the otp.
    @IBAction func verifyPhone(_ sender: UIButton) {
        
        guard  let phonenumber = mobileNumberTextField.text , !phonenumber.isEmpty else {
            alertDisplay(titleMsg: "", displayMessage: "Phone Number can't be empty.", buttonLabel: "Ok")
            return
        }
        guard  let username = usernameTextField.text , !username.isEmpty else {
            alertDisplay(titleMsg: "", displayMessage: "User name can't be empty.", buttonLabel: "Ok")
            return

        }
        guard  let dob = DOBTextField.text , !dob.isEmpty else {
            alertDisplay(titleMsg: "", displayMessage: "DOB can't be empty.", buttonLabel: "Ok")
            return

        }
        
        AuthManager.shared.sendingOTP(phonenumber) { [weak self] success in
          
            if success {
                DispatchQueue.main.async {
                    if let vc = self?.storyboard?.instantiateViewController(withIdentifier: "OTPViewController") as? OTPViewController {
                        self?.navigationController?.pushViewController(vc, animated: true)
                        
                    }else{
                        print("error in navigation may be you  have forgotten embeding navigationController.")
                    }
                }
            }
        }
        
          
            
    }
   
    func setupDatePicker() {
           // Set the date picker mode
           datePicker.datePickerMode = .date
           
           // Set preferred style for iOS 14+
           if #available(iOS 14, *) {
               datePicker.preferredDatePickerStyle = .inline
           }
           // Set the date picker as the input view for the text field
           DOBTextField.inputView = datePicker
           // Create a toolbar with a Done button
           let toolbar = UIToolbar()
           toolbar.sizeToFit()
           let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
           toolbar.setItems([doneButton], animated: true)
           // Set the toolbar as the accessory view for the text field
           DOBTextField.inputAccessoryView = toolbar
       }
    @objc func doneTapped() {
           // Format the date and set it as the text of the text field
           let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "dd/mm/yyyy"
           DOBTextField.text = formatter.string(from: datePicker.date)
           // Dismiss the date picker
           view.endEditing(true)
       }
   
    @objc func loginButtonTapped() {
           // Perform the shake animation
           let shakeAnimation = CABasicAnimation(keyPath: "position")
           shakeAnimation.duration = 0.1
           shakeAnimation.repeatCount = 2
           shakeAnimation.autoreverses = true
           let fromPoint = CGPoint(x: signUpButton.center.x - 10, y: signUpButton.center.y)
           let toPoint = CGPoint(x: signUpButton.center.x + 10, y: signUpButton.center.y)
           shakeAnimation.fromValue = NSValue(cgPoint: fromPoint)
           shakeAnimation.toValue = NSValue(cgPoint: toPoint)
           
           signUpButton.layer.add(shakeAnimation, forKey: "position")
           
       }
   
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
            // Handle the image tap
            print("Image tapped!")
            // Perform any action you want here
        PhotoGalleryManager.shared.showActionSheet(vc: self)
        PhotoGalleryManager.shared.imagePickerBlock = { [weak self] image in
            guard  let self = self  else {
                return
            }
            
            self.userimage.image = image
            
        }
        
        }
  

    func setUptextField(_ textfield:UITextField){
        textfield.layer.cornerRadius = 12
        textfield.clipsToBounds = true
    }
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        print("button got clicked")
        
        guard let username = usernameTextField.text , !username.isEmpty else {
            alertDisplay(titleMsg: "", displayMessage: "Username can't be empty", buttonLabel: "dismiss")
            return
        }
        guard let mobileNumber = mobileNumberTextField.text , !mobileNumber.isEmpty else {
            alertDisplay(titleMsg: "", displayMessage: "Mobile Number can't be empty", buttonLabel: "dismiss")
            return
        }
        
        if isValidPhone(phone: mobileNumber) {
            
        }else {
            alertDisplay(titleMsg: "", displayMessage: "Invalid Mobile number", buttonLabel: "Ok")
            return
        }
        guard let DOB = DOBTextField.text , !DOB.isEmpty else {
            alertDisplay(titleMsg: "", displayMessage: "Date of Birth can't be empty", buttonLabel: "dismiss")
            return
        }
        
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "OTPViewController") as? OTPViewController {
            vc.phoneNumber = mobileNumber
        }
      
      
        
    }
    
    @IBAction func logInButtonPressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        // Here, we will send the datas.
        vc.userimage = userimage.image
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

}









