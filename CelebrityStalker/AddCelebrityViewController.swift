//
//  AddCelebrityViewController.swift
//  CelebrityStalker
//
//  Created by Student on 10/19/15.
//  Copyright © 2015 Charles Findlay. All rights reserved.
//

import UIKit

protocol AddCelebrityViewControllerDelegate {
    func sendCelebrity(var name: String)
}

class AddCelebrityViewController: UIViewController {
    
    var newCeleb = Celebrity?()
    var delegate: AddCelebrityViewControllerDelegate?
    
    
    @IBOutlet weak var celebNameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func newCelebButton(sender: AnyObject) {
        delegate?.sendCelebrity(self.celebNameField.text!)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
}
