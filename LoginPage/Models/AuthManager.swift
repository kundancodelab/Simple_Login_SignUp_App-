import Foundation
import FirebaseCore
import FirebaseAuth

class AuthManager {
    
    static let shared = AuthManager()
    private let auth = Auth.auth()
    private var verificationId: String?
    
    public func startAuth(phoneNumber: String, completion: @escaping (Bool) -> Void) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { [weak self] verificationId, error in
            if let error = error  as? NSError{
                print("Error code: \(error.code)")
                print("Error starting auth: \(error.localizedDescription)")
                completion(false)
                return
            }
            guard let verificationId = verificationId else {
                print("Verification ID not received")
                completion(false)
                return
            }
            print("Verification ID received: \(verificationId)")
            self?.verificationId = verificationId
            completion(true)
        }
    }
    
    public func verificationCode(smsCode: String, completion: @escaping (Bool) -> Void) {
        guard let verificationId = verificationId else {
            print("Verification ID not found")
            completion(false)
            return
        }
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: smsCode)
        
        auth.signIn(with: credential) { result, error in
            if let error = error {
                print("Error verifying code: \(error.localizedDescription)")
                completion(false)
                return
            }
            guard result != nil else {
                print("No result returned from Firebase signIn")
                completion(false)
                return
            }
            print("Successfully authenticated")
            completion(true)
        }
    }
    public func sendingOTP(_ phoneNumber:String?  , compeletion : @escaping (Bool)-> Void ){
        guard let num = phoneNumber, !num.isEmpty else {
            compeletion(false)
            return
        }
        
        
        let number = "+91\(num)"
        print("Starting authentication for number: \(number)")
        AuthManager.shared.startAuth(phoneNumber: number) { [weak self] success in
            guard success else {
             
                print("Failed to start authentication")
                compeletion(false)
                return
            }
            DispatchQueue.main.async {
                compeletion(true)
                print("OTP sent successfully")
            }
        }
            
        }
    public func verifyingOTP(_ otp: String?) -> Bool {
        var flag = true
        if let text = otp, !text.isEmpty {
            let code = text
            print("Verifying OTP code: \(code)")
            AuthManager.shared.verificationCode(smsCode: code) { [weak self] success in
                guard success else {
                   // self?.alertDisplay(titleMsg: "", displayMessage: "Invalid OTP entered", buttonLabel: "Ok")
                   // self?.clearOTPFields()
                    flag = false
                    return
                }
                DispatchQueue.main.async {
                    print("OTP verified successfully")
                   // self?.navigateToHomePage()
                    flag = true
                }
            }
        }
        return flag 
    }
}
