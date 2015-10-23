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
    var newDictionary = NSDictionary()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        newDictionary = setParseData()
        
        let celeb1 = Celebrity(name: "Brad Pitt")
        let celeb2 = Celebrity(name: "Lionel Richie")
        let celeb3 = Celebrity(name: "James Franco")
       // let celeb4 = Celebrity(name: <#T##String#>)
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
        //call function that builds rest of celebrity properties from parsed data
        let updatedCeleb = searchParsedData(newDictionary, searchTerm: newCeleb)
        celebs.append(updatedCeleb)
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
                
            }
        }
        return searchTerm
        
    }
    
    
}

