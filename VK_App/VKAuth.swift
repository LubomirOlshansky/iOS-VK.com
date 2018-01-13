//
//  VKAuth.swift
//  VK_App
//
//  Created by Lubomir Olshansky on 26/09/2017.
//  Copyright © 2017 Lubomir Olshansky. All rights reserved.
//

import Foundation
import WebKit
import Alamofire

class VKAuth: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
        {
        didSet{
            webView.navigationDelegate = self
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "6197528"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "groups,offline,friends,photos, wall"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        webView.load(request)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension VKAuth: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        let token = params["access_token"]
        print(token)
        UserDefaults.standard.set(token!, forKey: "apiKey")
        UserDefaults.standard.synchronize()
       
           
        
        performSegue(withIdentifier: "loginComplete", sender: token)
        decisionHandler(.cancel)
        
    }
}

