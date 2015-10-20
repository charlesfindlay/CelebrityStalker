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
        celebrityNameLabel.text = "Lionel Ritchie"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func getNextCelebrityPhoto(sender: AnyObject) {
        // Hardcode the arguments
        let methodArguments: [String: String!] = [
            "method": METHOD_NAME,
            "api_key": API_KEY,
            "text": "Lionel Ritchie",
            "safe_search": SAFE_SEARCH,
            "extras": EXTRAS,
            "format": DATA_FORMAT,
            "nojsoncallback": NO_JSON_CALLBACK
        ]
        /* Call the Flickr API with these arguments */
        getImageFromFlickrByCelebrityName(methodArguments)
    }
    
    
    // MARK: Flickr API
    
    func getImageFromFlickrByCelebrityName(methodArguments: [String : AnyObject]) {
        
        /* 3 - Get the shared NSURLSession to faciliate network activity */
        let session = NSURLSession.sharedSession()
        
        /* 4 - Create the NSURLRequest using properly escaped URL */
        let urlString = BASE_URL + escapedParameters(methodArguments)
        let url = NSURL(string: urlString)!
        let request = NSURLRequest(URL: url)
        
        /* 5 - Create NSURLSessionDataTask and completion handler */
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                print("There was an error with your request: \(error)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                if let response = response as? NSHTTPURLResponse {
                    print("Your request returned an invalid response! Status code: \(response.statusCode)!")
                } else if let response = response {
                    print("Your request returned an invalid response! Response: \(response)!")
                } else {
                    print("Your request returned an invalid response!")
                }
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                print("No data was returned by the request!")
                return
            }
            
            /* Parse the data! */
            let parsedResult: [String:AnyObject]!
            do {
                parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as! [String : AnyObject]
            } catch {
                parsedResult = nil
                print("Could not parse the data as JSON: '\(data)'")
                return
            }
            
            /* GUARD: Did Flickr return an error? */
            guard let stat = parsedResult["stat"] as? String where stat == "ok" else {
                print("Flickr API returned an error. See error code and message in \(parsedResult)")
                return
            }
            
            /* GUARD: Is "photos" key in our result? */
            guard let photosDictionary = parsedResult["photos"] as? [String:AnyObject] else {
                print("Cannot find keys 'photos' in \(parsedResult)")
                return
            }
            
            print(photosDictionary)
            let photoArray = photosDictionary["photo"] as! [[String: AnyObject]]
            let randomIndex = Int(arc4random_uniform(UInt32(photoArray.count)))
            let myPhoto = photoArray[randomIndex] 
            let myURL = myPhoto["url_m"]
            print(myURL)
        
            
        }
        
        task.resume()
    }

    
    
    
    
    // MARK: Escape HTML Parameters
    
    func escapedParameters(parameters: [String : AnyObject]) -> String {
        
        var urlVars = [String]()
        
        for (key, value) in parameters {
            
            /* Make sure that it is a string value */
            let stringValue = "\(value)"
            
            /* Escape it */
            let escapedValue = stringValue.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            
            /* Append it */
            urlVars += [key + "=" + "\(escapedValue!)"]
            
        }
        
        return (!urlVars.isEmpty ? "?" : "") + urlVars.joinWithSeparator("&")
    }

}
