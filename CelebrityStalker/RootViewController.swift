//
//  RootViewController.swift
//  CelebrityStalker
//
//  Created by Student on 10/19/15.
//  Copyright © 2015 Charles Findlay. All rights reserved.
//

import UIKit


class RootViewController: UITableViewController, AddCelebrityViewControllerDelegate {
    
    var celebs:[Celebrity] = []
    var selectedCeleb: Int?    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let celeb1 = Celebrity(name: "Brad Pitt")
        let celeb2 = Celebrity(name: "Lionel Richie")
        let celeb3 = Celebrity(name: "James Franco")
        celeb3.birthdate = "April 19, 1978"
        celebs=[celeb1, celeb2, celeb3]

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    // MARK: - Table view data source


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return celebs.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("celebNameCell")
        cell?.textLabel?.text = celebs[indexPath.row].name
        
        return cell!
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedCeleb = indexPath.row
        self.performSegueWithIdentifier("celebDetailsSegue", sender: indexPath.row)
    }
    
    
    // MARK: - Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addCelebSegue" {
            let vc = segue.destinationViewController as! AddCelebrityViewController
            vc.delegate = self
        }
        if segue.identifier == "celebDetailsSegue"  {
            let vc = segue.destinationViewController as! CelebrityTabBarController
            
            vc.myCelebrity = celebs[selectedCeleb!]
            
        }
        
    }
    
    // MARK: - Delegate & Protocol 
    
    func sendCelebrity(name: String) {
        let newCeleb = Celebrity(name: name)
        celebs.append(newCeleb)
        tableView.reloadData()
    }
    
    
}

