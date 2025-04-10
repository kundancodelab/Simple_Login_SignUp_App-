//
//  SetingsVC.swift
//  LoginPage
//
//  Created by Kundan ios dev  on 22/07/24.
//

import UIKit
import FirebaseAuth

class SetingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    


    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            // Navigate to LogicVC
            navigateToLogicVC()
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError.localizedDescription)")
        }
        
    }
    private func navigateToLogicVC() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let logicVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            let navVC = UINavigationController(rootViewController: logicVC)
            
            // Ensure to get the active window scene
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                window.rootViewController = navVC
                window.makeKeyAndVisible()
            }
        }
    
    @IBAction func goBackButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
}
