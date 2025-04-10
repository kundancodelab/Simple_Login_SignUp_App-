//
//  HomeVC.swift
//  LoginPage
//
//  Created by Kundan ios dev  on 21/07/24.
//

import UIKit

class HomeVC: UIViewController {

    
    @IBOutlet weak var userImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(userImageTapped))
                userImage.addGestureRecognizer(tapGesture)
                userImage.isUserInteractionEnabled = true
    }
    @objc private func userImageTapped() {
            print("image got clicked")
       
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SetingsVC") as? SetingsVC {
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
            
        }else{
            print("something went wrong! ")
        }
            
        
        
        }

    
}
