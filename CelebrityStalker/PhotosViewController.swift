//
//  PhotosViewController.swift
//  CelebrityStalker
//
//  Created by Student on 10/20/15.
//  Copyright © 2015 Charles Findlay. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {

    
    @IBOutlet weak var celebrityNameLabel: UILabel!
    @IBOutlet weak var celebrityPhotoDisplay: UIImageView!
    
    @IBOutlet weak var photoTextDisplay: UILabel!
    
    
    
    
    // MARK: - Globals
    
    let BASE_URL = "https://api.flickr.com/services/rest/"
    let METHOD_NAME = "flickr.photos.search"
    let API_KEY = "8b7e5c3ee11d2b7c21e5d9a563c3ac83"
    let EXTRAS = "url_m"
    let SAFE_SEARCH = "1"
    let DATA_FORMAT = "json"
    let NO_JSON_CALLBACK = "1"
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func getNextCelebrityPhoto(sender: AnyObject) {
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
