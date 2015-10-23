//
//  RootViewController.swift
//  CelebrityStalker
//
//  Created by Student on 10/19/15.
//  Copyright © 2015 Charles Findlay. All rights reserved.
//

import UIKit


class RootViewController: UITableViewController, AddCelebrityViewControllerDelegate {
    
    @IBOutlet weak var reorderButton: UIBarButtonItem!
    
    var celebs:[Celebrity] = []
    var selectedCeleb: Int?
    var newDictionary = NSDictionary()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        newDictionary = setParseData()

        
        for (key, value) in newDictionary {
            let thisCeleb = key
            print(thisCeleb)
            let eachCeleb = Celebrity(name: thisCeleb as! String)
            populateCelebsArray(eachCeleb)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func beginEditingCelebrityList(sender: AnyObject) {
        
        // This code will function as a toggle switch to turn editing capability on or off.
        if tableView.editing == true {
            tableView.setEditing(false, animated: true)
            reorderButton.title = "Reorder"
        }
        else {
            tableView.setEditing(true, animated: true)
            reorderButton.title = "Done"
        }
        
    }
    
    // MARK: - Table view functions


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
    
    
    
    // When Table view is in edit mode, this code will display the three edit lines on the right hand side
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete
    }
    
    // Checks whether a particular row can be moved
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // Sets whether table rows should be indented right when in edit mode
    override func tableView(tableView: UITableView, shouldIndentWhileEditingRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let movedObject = self.celebs[sourceIndexPath.row]
        celebs.removeAtIndex(sourceIndexPath.row)
        celebs.insert(movedObject, atIndex: destinationIndexPath.row)
        tableView.reloadData()
        
    }
    
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            celebs.removeAtIndex(indexPath.row)
            tableView.reloadData()
        }
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
    
    // MARK: - Delegate & Utility Functions
    
    func sendCelebrity(name: String) {
        let newCeleb = Celebrity(name: name)
        celebs.append(newCeleb)
        tableView.reloadData()
    }
    
    func populateCelebsArray(celeb: Celebrity) {
        let eachCeleb = searchParsedData(newDictionary, searchTerm: celeb)
        celebs.append(eachCeleb)
        tableView.reloadData()
    }
    
    func setParseData() -> NSDictionary {
        let parser = CelebrityJSONParser()
        let celebJson = parser.parsedCelebrityJSON
        print(celebJson.count)
        
        return celebJson
    }
    
    func searchParsedData(dict: NSDictionary, searchTerm: Celebrity) -> Celebrity {
        for (key,value)in dict {
            if key as! String == searchTerm.name {
                searchTerm.realName = value["realname"] as! String
                searchTerm.birthplace = value["birthplace"] as! String
                searchTerm.birthdate = value["birthday"] as! String
                searchTerm.maritalStatus = value["status"] as! String
                searchTerm.videoID = value["videoID"] as! String
            }
        }
        return searchTerm
        
    }
    
    
}

