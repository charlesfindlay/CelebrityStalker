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
    @IBOutlet weak var birthdayLabel: UITextField!
    @IBOutlet weak var birthPlaceLabel: UITextField!
    @IBOutlet weak var realNameLabel: UITextField!
    @IBOutlet weak var maritalStatusLabel: UITextField!
    
    
    var myCelebrity = Celebrity?()

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tbvc = self.tabBarController as? CelebrityTabBarController
        myCelebrity = tbvc!.myCelebrity
        
        celebrityNameLabel.text = myCelebrity?.name
        realNameLabel.text = myCelebrity?.realName
        birthdayLabel.text = myCelebrity?.birthdate
        birthPlaceLabel.text = myCelebrity?.birthplace
        maritalStatusLabel.text = myCelebrity?.maritalStatus


    }

    
    
    @IBAction func saveChangesButton(sender: AnyObject) {
        myCelebrity?.realName = realNameLabel.text!
        myCelebrity?.birthdate = birthdayLabel.text!
        myCelebrity?.birthplace = birthPlaceLabel.text!
        myCelebrity?.maritalStatus = maritalStatusLabel.text!
    }
    
    
    

}
