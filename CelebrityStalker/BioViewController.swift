//
//  BioViewController.swift
//  CelebrityStalker
//
//  Created by GLR on 10/21/15.
//  Copyright © 2015 Charles Findlay. All rights reserved.
//

import UIKit

class BioViewController: UIViewController, PickCelebrityToViewDelegate {
    
    var myCelebrity = Celebrity?()

    @IBOutlet weak var testLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // print(myCelebrity!.name)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func testButton(sender: AnyObject) {
        testLabel.text = myCelebrity!.name
    }
    
    func pickCelebrity(myCelebrity: Celebrity) {
        self.myCelebrity = myCelebrity
        print(myCelebrity.name)
    }

}
