//
//  UIViewController+Extension.swift
//  LoginPage
//
//  Created by User on 10/04/25.
//

import Foundation
import UIKit
extension  UIViewController {
    func setTextFieldColor(_ myTextField: UITextField, _ placeholderString: String) {
       // creating custome color for placeholder.
       let customColor = UIColor(hex: "3D7962")
       let placeholderAttributes: [NSAttributedString.Key: Any] = [
           .foregroundColor: customColor,
           .font: UIFont.boldSystemFont(ofSize: myTextField.font?.pointSize ?? 17)
       ]
       myTextField.attributedPlaceholder = NSAttributedString(
           string: placeholderString,
           attributes: placeholderAttributes
       )
   }
}
 
