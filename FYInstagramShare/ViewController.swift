//
//  ViewController.swift
//  FYInstagramShare
//
//  Created by Farhan Yousuf on 18/07/16.
//  Copyright © 2016 July Systems Pvt. Ltd. All rights reserved.
//

import UIKit

struct ShareToInstagramConstants {
    static let DekhoInstagramClientID:String = "cc70510ad9414a65ab099943452f9519"
    static let DekhoInstagramClientSecret:String = "18a1313ae3e44328a999e9ea264c3442"
    
    static let InstagramLoginViewControllerRedirectURI:String = "https://www.google.com"
//    static let InstagramLoginViewControllerRedirectURI:String = "fyinstagram://"
    static let InstagramLoginViewControllerIdentifier:String = "InstagramLoginViewControllerIdentifier"
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    ////////////////////////////////////////////////////////////////
    //
    // MARK: Share Action
    //
    ////////////////////////////////////////////////////////////////

    @IBAction func buttonActionShareToInstagram(sender: AnyObject) {
        
        if let instagramLoginViewController = self.storyboard?.instantiateViewControllerWithIdentifier(ShareToInstagramConstants.InstagramLoginViewControllerIdentifier) as? FYWebViewController {
            
            instagramLoginViewController.delegate = self
            self.presentViewController(instagramLoginViewController, animated: true, completion: nil)
        }
        
        
    }

}

extension ViewController:FYInstagramLoginProtocol {
    
    func didSuccessfullyGenerateAccessToken(token: String) {
        dismissViewControllerAnimated(true) { 
            
        }
    }
    
    func didFailToGenerateAccessTokenWithError(error: NSError?) {
        dismissViewControllerAnimated(true) { 
            
            self.handleErrorWithTitle("Error", message: error?.localizedDescription)
            
        }
    }
}

extension UIViewController {
    
    func handleErrorWithTitle(title:String?, message:String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .Destructive, handler: {[unowned self] (action) in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
}
