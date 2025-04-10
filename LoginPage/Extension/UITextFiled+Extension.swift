//
//  UITextFiled+Extension.swift
//  LoginPage
//
//  Created by User on 10/04/25.
//

import Foundation
import UIKit
// MARK: - UITextfield Extention

extension SignUpVCViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
