//
//  UIView+Extension.swift
//  LoginPage
//
//  Created by User on 10/04/25.
//

import Foundation
import UIKit 
extension UIView{
    func setUPUiView(_ uiView:UIView){
        
        uiView.clipsToBounds = true
        uiView.layer.borderWidth = 0.2
        uiView.layer.cornerRadius = 20
        
    }
}
