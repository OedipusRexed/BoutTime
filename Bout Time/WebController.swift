//
//  WebController.swift
//  Bout Time
//
//  Created by Aaron Revalee on 11/13/17.
//  Copyright © 2017 OedipusRexed. All rights reserved.
//

import Foundation
import UIKit

class WebController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    
    var clickedFirst: URL?
    var clickedSecond: URL?
    var clickedThird: URL?
    var clickedFourth: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        
        if let clickedLink = clickedFirst {
            let request = URLRequest(url: clickedLink)
            webView.loadRequest(request)
        }
        
        if let clickedLink = clickedSecond {
            let request = URLRequest(url: clickedLink)
            webView.loadRequest(request)
        }
        
        if let clickedLink = clickedThird {
            let request = URLRequest(url: clickedLink)
            webView.loadRequest(request)
        }
        
        if let clickedLink = clickedFourth {
            let request = URLRequest(url: clickedLink)
            webView.loadRequest(request)
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        webView.stopLoading()
        clickedFirst = nil
        clickedSecond = nil
        clickedThird = nil
        clickedFourth = nil
    }
}
