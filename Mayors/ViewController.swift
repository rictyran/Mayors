//
//  ViewController.swift
//  Mayors
//
//  Created by Richard Tyran on 3/5/15.
//  Copyright (c) 2015 Richard Tyran. All rights reserved.
//

import UIKit
import Crashlytics
//import AFNetworking

let AUTH_URL = "https://foursquare.com/oauth2/authenticate?client_id=IXZFUHN4OSK3GQ5I2FFBB0CUOWO4CF4P43LHUWM1OS323FG3&response_type=token&redirect_uri=mayors://mayors.com"


class ViewController: UIViewController {

    @IBOutlet var welcomeLabel: UILabel!
    
    @IBAction func foursquareConnect(sender: AnyObject) {
        
        if let url = NSURL(string: AUTH_URL) {
            
            UIApplication.sharedApplication().openURL(url)
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserverForName("FSConnectionWithToken", object: nil, queue: NSOperationQueue.mainQueue()) { (notification) -> Void in
            
            // code is run after token is set
            
//            println(FoursquareModel.mainModel().token)
            
            let ME_URL = "https://api.foursquare.com/v2/users/self"
            
            let rMananger = AFHTTPRequestOperationManager()
            
            rMananger.GET(ME_URL, parameters:["oauth_token":FoursquareModel.mainModel().token!,"v":"20150311","m":"foursquare"], success: { (operation, response) -> Void in
                
//                println(response)
                
//                let resultInfo = response as [String:AnyObject]
//                                
//                let firstName = userInfo["firstName"] as String
//                let lastName = userInfo["lastName"] as String
//                
//                self.welcomeLabel.text = "Welcome \(firstName) \(lastName)"
//                
                let user = User(resultInfo: response as [String:AnyObject])
                
                self.welcomeLabel.text = "Welcome \(user.firstName) \(user.lastName)"
                
            }, failure: { (operation, error) -> Void in
                
                println(error)
                
            })
            
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    
//    let manager = AFHTTPRequestOperationManager()
//        
//        
//        manager.GET("http://jo2.com/twitter.json", parameters: nil, success: { (operation, responseObject) -> Void in
//        
//            println(responseObject)
//            
//        }) { (operation, error) -> Void in
        
//        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

