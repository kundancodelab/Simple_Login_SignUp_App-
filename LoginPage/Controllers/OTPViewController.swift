import UIKit
import AEOTPTextField


 class CenteredCursorOTPTextField: AEOTPTextField {
    override func caretRect(for position: UITextPosition) -> CGRect {
        var originalRect = super.caretRect(for: position)
        
        let width = self.bounds.width / CGFloat(self.text?.count ?? 1)
        originalRect.origin.x = (width - originalRect.width) / 2
        
        return originalRect
    }
}

class OTPViewController: UIViewController {

    @IBOutlet weak var otpTextField: CenteredCursorOTPTextField!
    @IBOutlet weak var timerLabel: UILabel!
    
    var otp: String?
    var phoneNumber: String?
    var timer: Timer?
    var secondsRemaining = 60

    override func viewDidLoad() {
        super.viewDidLoad()

        otpTextField.otpDelegate = self
        otpTextField.configure(with: 6)
        otpTextField.otpFontSize = 16
        otpTextField.otpTextColor = .systemRed
        otpTextField.otpCornerRaduis = 5
        otpTextField.otpFilledBorderColor = .blue
        
        startTimer()
        
        if let number = phoneNumber {
            phoneNumber = number
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    func startTimer() {
        secondsRemaining = 60
        updateTimerLabel()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if secondsRemaining > 0 {
            secondsRemaining -= 1
            updateTimerLabel()
        } else {
            timer?.invalidate()
            timer = nil
            timerExpired()
        }
    }

    func updateTimerLabel() {
        timerLabel.text = "\(secondsRemaining)s"
    }

    func timerExpired() {
        // Handle timer expiration, e.g., allow user to request a new OTP
        print("Timer expired")
        alertDisplay(titleMsg: "Time Out", displayMessage: "Your OTP has expired. Please request a new OTP.", buttonLabel: "Ok")
    }

    func navigateToHomePage() {
        if let vc = self.storyboard?.instantiateViewController(identifier: "HomeVC") as? HomeVC {
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        } else {
            print("Navigation error!")
        }
    }

    func clearOTPFields() {
        otpTextField.text = ""
    }

    @IBAction func submitButtonPressed(_ sender: UIButton) {
        if  AuthManager.shared.verifyingOTP(otp) {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC {
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
        }else{
            alertDisplay(titleMsg: "", displayMessage: "Invalid OTP entered", buttonLabel: "Ok")
        }
    }
    
    @IBAction func resendOTP(_ sender: UIButton) {
        print(" we will write here code to send the otp.")
        AuthManager.shared.sendingOTP(phoneNumber) {[weak self ] success in
            if success {
                DispatchQueue.main.async {
                    self?.startTimer()
                }
            }
            
        }
          
         
       }
    
    @IBAction func goBackButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

// MARK: - AEOTPTextFieldDelegate

extension OTPViewController: AEOTPTextFieldDelegate {
    func didUserFinishEnter(the code: String) {
        print(code)
        otp = code
    }
}
