//
//  BioViewController.swift
//  CelebrityStalker
//
//  Created by GLR on 10/21/15.
//  Copyright © 2015 Charles Findlay. All rights reserved.
//

import UIKit

class BioViewController: UIViewController {
    
    
    @IBOutlet weak var celebrityNameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    
    
    var myCelebrity = Celebrity?()

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tbvc = self.tabBarController as? CelebrityTabBarController
        myCelebrity = tbvc!.myCelebrity
        
        celebrityNameLabel.text = myCelebrity?.name
        birthdayLabel.text = myCelebrity?.birthdate


    }

    
    
    @IBAction func editCelebrityDetails(sender: AnyObject) {
    }
    
    
    

}
