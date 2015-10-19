//
//  RootViewController.swift
//  CelebrityStalker
//
//  Created by Student on 10/19/15.
//  Copyright © 2015 Charles Findlay. All rights reserved.
//

import UIKit

class RootViewController: UITableViewController {
    
    var celebs:[Celebrity] = []
    var selectedCeleb: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        let celeb1 = Celebrity(name: "Brad Pitt")
        let celeb2 = Celebrity(name: "Lionel Ritchie")
        let celeb3 = Celebrity(name: "James Franco")
        celebs=[celeb1, celeb2, celeb3]
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
}