//
//  WebViewController.swift
//  VinodTaskProjectTests
//
//  Created by Vinod K on 07/04/20.
// Copyright © 2020 Vinod K. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //to display webview with url request
        
        let myURL = URL(string: selectedWebPage)
               let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
//        webView.navigationDelegate = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
