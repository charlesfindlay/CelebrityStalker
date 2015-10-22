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
    
    var celebrityPhotoArray: [[String:AnyObject]] = []
    var myCelebrity = Celebrity?()
    
    // MARK: - Globals
    
    let BASE_URL = "https://api.flickr.com/services/rest/"
    let METHOD_NAME = "flickr.photos.search"
    let API_KEY = "8b7e5c3ee11d2b7c21e5d9a563c3ac83"
    let EXTRAS = "url_m"
    let SAFE_SEARCH = "1"
    let DATA_FORMAT = "json"
    let NO_JSON_CALLBACK = "1"
    let PER_PAGE = "500"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tbvc = self.tabBarController as? CelebrityTabBarController
            myCelebrity = tbvc!.myCelebrity
            celebrityNameLabel.text = myCelebrity!.name
        
        
        // Hardcode the arguments
        let methodArguments: [String: String!] = [
            "method": METHOD_NAME,
            "api_key": API_KEY,
            "text": "\(myCelebrity!.name)",
            "safe_search": SAFE_SEARCH,
            "extras": EXTRAS,
            "format": DATA_FORMAT,
            "nojsoncallback": NO_JSON_CALLBACK,
            "per_page": PER_PAGE
        ]
        /* Call the Flickr API with these arguments */
        getImageFromFlickrByCelebrityName(methodArguments)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func getNextCelebrityPhoto(sender: AnyObject) {
        randomSelectNextCelebrityPhoto()
    }
    
    func randomSelectNextCelebrityPhoto() {
        
        let randomIndex = Int(arc4random_uniform(UInt32(celebrityPhotoArray.count)))
        let myPhoto = celebrityPhotoArray[randomIndex]
        let myURL = myPhoto["url_m"] as! String
        
        let imageURL = NSURL(string: myURL)
        let photoTitle = myPhoto["title"] as? String
        
        if let imageData = NSData(contentsOfURL: imageURL!) {
            self.photoTextDisplay.text =  photoTitle
            self.celebrityPhotoDisplay.image = UIImage(data: imageData)
            
        } else {
            print("Image does not exist at \(imageURL)")
        }
        
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
            let photoArray = photosDictionary["photo"] as! [[String: AnyObject]]
            
            // I'm assuming this is needed to properly update the class variable holding the photo array
            dispatch_async(dispatch_get_main_queue(), {
                self.celebrityPhotoArray =  photoArray
                self.randomSelectNextCelebrityPhoto()
            })
            
            
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
