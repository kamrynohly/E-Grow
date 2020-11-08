//
//  FirstViewController.swift
//  E-Grow2
//
//  Created by Kamryn Ohly on 11/7/20.
//  Copyright © 2020 Kamryn Ohly. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 22
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.init(red: 224/255, green: 224/255, blue: 224/255, alpha: 1).cgColor
        signupButton.layer.cornerRadius = 22
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
