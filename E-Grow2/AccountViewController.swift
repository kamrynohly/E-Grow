//
//  AccountViewController.swift
//  E-Grow2
//
//  Created by Kamryn Ohly on 11/7/20.
//  Copyright © 2020 Kamryn Ohly. All rights reserved.
//

import UIKit
import Firebase

class AccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logOutPressed(_ sender: UIButton) {
        
        do {
               try Auth.auth().signOut()
           }
        catch let signOutError as NSError {
               print ("Error signing out: %@", signOutError)
           }
           
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
           let initial = storyboard.instantiateInitialViewController()
           UIApplication.shared.keyWindow?.rootViewController = initial
        
    }
    
    @IBAction func addCompost(_ sender: Any) {
    }
    
    @IBAction func addRecycling(_ sender: Any) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
