//
//  Celebrity.swift
//  CelebrityStalker
//
//  Created by Student on 10/19/15.
//  Copyright © 2015 Charles Findlay. All rights reserved.
//

import Foundation

class Celebrity {
    let name: String
    var realName = "same"
    var birthdate: String
    var birthplace: String
    var maritalStatus: String
    var bioSource: String
    var videoID: String
    
    
    init(name: String) {
        self.name = name
        self.birthdate = ""
        self.birthplace = ""
        self.maritalStatus = ""
        self.bioSource = ""
        self.videoID = ""
    }
    
    
    func addNewCelebrity(newName: String) {
        
    }
}