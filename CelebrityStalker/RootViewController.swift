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

