//
//  CelebrityJSONParser.swift
//  CelebrityStalker
//
//  Created by Student on 10/22/15.
//  Copyright © 2015 Charles Findlay. All rights reserved.
//

import Foundation

class CelebrityJSONParser {
    
    
    /* Path for JSON files bundled with the Playground */
    var pathForCelebrityJSON = NSBundle.mainBundle().pathForResource("celebBio", ofType: "JSON")
    
    /* Raw JSON data (...simliar to the format you might receive from the network) */
    var rawCelebrityJSON: NSData
    
    /* Error object */
    var parsingCelebrityError: NSError? = nil
    
    /* Parse the data into usable form */
    var parsedCelebrityJSON: NSDictionary
    
    init() {
        
        rawCelebrityJSON = NSData(contentsOfFile: pathForCelebrityJSON!)!
        parsedCelebrityJSON = try! NSJSONSerialization.JSONObjectWithData(rawCelebrityJSON, options: .AllowFragments) as! NSDictionary
    }
    
    
    
    
    

}