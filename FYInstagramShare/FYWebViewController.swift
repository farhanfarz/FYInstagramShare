//
//  FYWebViewController.swift
//  FYInstagramShare
//
//  Created by Farhan Yousuf on 18/07/16.
//  Copyright © 2016 July Systems Pvt. Ltd. All rights reserved.
//

import UIKit

@objc protocol FYInstagramLoginProtocol : NSObjectProtocol {
    
    func didSuccessfullyGenerateAccessToken(token:String)
    func didFailToGenerateAccessTokenWithError(error:NSError?)
}

class FYWebViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    var delegate:FYInstagramLoginProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        if let url = NSURL(string: "https://api.instagram.com/oauth/authorize/?client_id=\(ShareToInstagramConstants.DekhoInstagramClientID)&redirect_uri=\(ShareToInstagramConstants.InstagramLoginViewControllerRedirectURI)&response_type=token") {
            webView.loadRequest(NSURLRequest(URL: url))
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension FYWebViewController: UIWebViewDelegate {
    
    func webViewDidStartLoad(webView: UIWebView) {
        
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        delegate?.didFailToGenerateAccessTokenWithError(error)
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        if let url = request.URL {
            if url.absoluteString.containsString("\(ShareToInstagramConstants.InstagramLoginViewControllerRedirectURI)/#") {
                let callbackStringArray = url.absoluteString.componentsSeparatedByString("#")
                if callbackStringArray.count == 2 {
                    let accessTokenString = callbackStringArray[1]
                    delegate?.didSuccessfullyGenerateAccessToken(accessTokenString)
                }
            }
        }
        return true
    }
    
}