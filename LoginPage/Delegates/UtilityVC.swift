
//  UtilityVC.swift
//  Tmeric
//  Created by Prince on 03/01/22.

import UIKit
import SystemConfiguration
import Foundation
//import Alamofire

class UtilityVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}

extension UIViewController{
    
    /*
      // how to use this below function in code :
      if isValidEmail(testStr: "kirit@gmail.com"){
          print("Validate EmailID")
      }else{
       print("invalide EmailID")
      }
      
      */
     
     /*
      Email Validation
      */
     func isValidEmail(email: String) -> Bool {
             let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
             let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
             return emailTest.evaluate(with: email)
         }
     
     /*
      Phone Number Validation
      */
     func isValidPhone(phone: String) -> Bool {
             let phoneRegex = "^[0-9+]{0,1}+[0-9]{9,9}$"
             let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
             return phoneTest.evaluate(with: phone)
        }
     
    /*
      // new method to check the password correct or not based on certain condition.
     */
    
    func isPasswordValid(password: String) -> Bool {
           return isAtLeastEightCharacters(password: password) &&
                  containsUppercaseAndLowercase(password: password) &&
                  containsNumberAndSpecialCharacter(password: password)
       }
       // checking our password must be containg 8 character long
       func isAtLeastEightCharacters(password: String) -> Bool {
           return password.count >= 8
       }
       // checking our password containing lowercase  and uppercase latter or not
       func containsUppercaseAndLowercase(password: String) -> Bool {
          
               let hasUppercase = password.contains { $0.isUppercase }
               let hasLowercase = password.contains { $0.isLowercase }
               return hasUppercase && hasLowercase
           

       }
       
       func containsNumberAndSpecialCharacter(password: String) -> Bool {
            return containsNumber(password: password) && containsSpecialCharacter(password: password)
       }
    /*
      Password validation code.
     */
    func validatePassword(password: String) -> String? {
        if !isAtLeastEightCharacters(password: password) {
               return "Password must be at least 8 characters long."
           }
           if !containsUppercaseAndLowercase(password: password) {
               return "Password must include a mix of uppercase and lowercase letters."
           }
           if !containsNumberAndSpecialCharacter(password: password) {
               if !containsNumber(password: password) {
                   return "Password must include at least one number."
               }
               if !containsSpecialCharacter(password: password) {
                   return "Password must include at least one special character."
               }
           }
           return nil
    }
     // checking our password contains number or not
    func containsNumber(password: String) -> Bool {
        let numberPattern = ".*[0-9]+.*"
        let numberPredicate = NSPredicate(format: "SELF MATCHES %@", numberPattern)
        return numberPredicate.evaluate(with: password)
    }
   // checking our password contains specail character or not
    func containsSpecialCharacter(password: String) -> Bool {
        let specialCharacterPattern = ".*[!@#$%^&*(),.?\":{}|<>]+.*"
        let specialCharacterPredicate = NSPredicate(format: "SELF MATCHES %@", specialCharacterPattern)
        return specialCharacterPredicate.evaluate(with: password)
    }




     /*
       Pincode Validation
      */
     
     func isValidPincode(value: String) -> Bool {
         if value.count == 6{
           return true
         }
         else{
           return false
         }
     }
     /*
       Password Validation : Check current and Confirm is Same.
      */
     func isPasswordSame(password: String , confirmPassword : String) -> Bool {
         if password == confirmPassword{
           return true
         }else{
           return false
         }
     }
     
     /*
        Password length Validation - Length should grater than 7.
      */
     func isPwdLenth(password: String , confirmPassword : String) -> Bool {
             if password.count >= 8 && confirmPassword.count >= 8{
                return true
             }else{
                return false
             }
         }
    
    /*   Function to check valid name */
    func isValidName(_ name: String?, minLength: Int = 2) -> Bool {
        guard let name = name, !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        // Check if the name meets the minimum length requirement
        if name.trimmingCharacters(in: .whitespaces).count < minLength {
            return false
        }
        
        // Regular expression to check for alphabetic characters only
        let nameRegex = "^[A-Za-z]+$"
        let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return namePredicate.evaluate(with: name)
    }
     /* Function to check valid address  */
    func isValidAddress(_ address: String?, minLength: Int = 5) -> Bool {
        guard let address = address, !address.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        // Check if the address meets the minimum length requirement
        if address.trimmingCharacters(in: .whitespaces).count < minLength {
            return false
        }
        
        // Regular expression to check for valid address characters
        let addressRegex = "^[A-Za-z0-9.,'\\-\\s]+$"
        let addressPredicate = NSPredicate(format: "SELF MATCHES %@", addressRegex)
        return addressPredicate.evaluate(with: address)
    }

 
    /* function to check valid Mobile Number */
    func isValidMobileNumber(_ mobileNumber: String?) -> Bool {
        guard let mobileNumber = mobileNumber, !mobileNumber.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        let mobileNumberRegex = "^[0-9]{10}$" // Assuming a 10-digit mobile number
        let mobileNumberPredicate = NSPredicate(format: "SELF MATCHES %@", mobileNumberRegex)
        return mobileNumberPredicate.evaluate(with: mobileNumber)
    }
/* Function to check valid zip code */
    func isValidIndianZipCode(_ zipCode: String?) -> Bool {
        guard let zipCode = zipCode, !zipCode.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        // Regular expression to check for valid Indian zip code formats
        let zipCodeRegex = "^[1-9][0-9]{5}$"
        let zipCodePredicate = NSPredicate(format: "SELF MATCHES %@", zipCodeRegex)
        return zipCodePredicate.evaluate(with: zipCode)
    }

    func alertDisplay(titleMsg: String, displayMessage:String , buttonLabel: String) {
        
        let alert = UIAlertController(title: titleMsg, message: displayMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: buttonLabel, style: .default, handler: nil)
        alert.addAction(okAction)
              
        self.present(alert, animated: true, completion: nil)
    }
    
    func hideKeyboardWhenTappedAround() {
            let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
        }
        
        @objc func dismissKeyboard() {
            view.endEditing(true)
        }
    //MARK: - Toast message design -
    //TO show a toast message
    func showToast(message : String, font: UIFont) {
        DispatchQueue.main.async {
            let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 130, y: self.view.frame.size.height - 170, width: 250, height: 35))
            toastLabel.backgroundColor = UIColor.white.withAlphaComponent(0.75)
            toastLabel.textColor = UIColor.black
            toastLabel.font = font
            toastLabel.textAlignment = .center;
            toastLabel.text = message
            toastLabel.alpha = 1.0
            toastLabel.layer.cornerRadius = 10;
            toastLabel.clipsToBounds  =  true
            self.view.addSubview(toastLabel)
            UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }, completion: {(isCompleted) in
                toastLabel.removeFromSuperview()
            })
        }
    }
}

public class Reachability {

    class func isConnectedToNetwork() -> Bool {

        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }

        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }

        /* Only Working for WIFI
        let isReachable = flags == .reachable
        let needsConnection = flags == .connectionRequired

        return isReachable && !needsConnection
        */

        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)

        return ret

    }
}

class FileDownloader {

    static func loadFileSync(url: URL, completion: @escaping (String?, Error?) -> Void)
    {
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)

        if FileManager().fileExists(atPath: destinationUrl.path)
        {
            print("File already exists [\(destinationUrl.path)]")
            completion(destinationUrl.path, nil)
        }
        else if let dataFromURL = NSData(contentsOf: url)
        {
            if dataFromURL.write(to: destinationUrl, atomically: true)
            {
                print("file saved [\(destinationUrl.path)]")
                completion(destinationUrl.path, nil)
            }
            else
            {
                print("error saving file")
                let error = NSError(domain:"Error saving file", code:1001, userInfo:nil)
                completion(destinationUrl.path, error)
            }
        }
        else
        {
            let error = NSError(domain:"Error downloading file", code:1002, userInfo:nil)
            completion(destinationUrl.path, error)
        }
    }

    static func loadFileAsync(url: URL, completion: @escaping (String?, Error?) -> Void)
    {
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)

        if FileManager().fileExists(atPath: destinationUrl.path){
            try! FileManager.default.removeItem(at: destinationUrl)
        }
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request, completionHandler:
        {
            data, response, error in
            if error == nil
            {
                if let response = response as? HTTPURLResponse
                {
                    if response.statusCode == 200
                    {
                        if let data = data
                        {
                            if let _ = try? data.write(to: destinationUrl, options: Data.WritingOptions.atomic)
                            {
                                completion(destinationUrl.path, error)
                            }
                            else
                            {
                                completion(destinationUrl.path, error)
                            }
                        }
                        else
                        {
                            completion(destinationUrl.path, error)
                        }
                    }
                }
            }
            else
            {
                completion(destinationUrl.path, error)
            }
        })
        task.resume()
    }
}

// MARK: - PhotoGalleryManager class responsible for pick profile picture of the user either from camera a phone gallery 
/* How will you use this file here is example code just copy and paste where you want to let user pick picture
 
 // example code.
 PhotoGalleryManager.shared.showActionSheet(vc: self)
 PhotoGalleryManager.shared.imagePickerBlock = { [weak self] image in
     guard  let self = self  else {
         return
     }
     
     self.imageView.image = image
     
 }

 
 */
class PhotoGalleryManager:NSObject {
    static let shared = PhotoGalleryManager()
    fileprivate var currentVC:UIViewController!
    var imagePickerBlock:((UIImage) -> Void)?
    
  private  func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = .camera
            pickerController.allowsEditing = true
            currentVC.present(pickerController, animated: true)
        }
    }
    
    
    
   private  func openPhotoGallery(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = .photoLibrary
            pickerController.allowsEditing = true
            currentVC.present(pickerController, animated: true)
        }
    }
    
    
    func showActionSheet( vc : UIViewController){
        currentVC = vc
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle:.actionSheet)
        actionSheet.addAction(UIAlertAction(title: "camera", style: .default, handler: {[weak self] _ in
            self?.openCamera()
        }))
        actionSheet.addAction(UIAlertAction(title: "Gallary", style: .default, handler: {[weak self] _ in
            self?.openPhotoGallery()
        }))
        actionSheet.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
        vc.present(actionSheet, animated: true)
        
    }
    
    
}

extension PhotoGalleryManager:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        currentVC.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imagePickerBlock?(image)
        }
        currentVC.dismiss(animated: true, completion: nil)
    }
}
    
