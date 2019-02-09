//
//  WebViewController.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 4/20/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    let url = URL (string: "https://docs.google.com/forms/d/e/1FAIpQLScHpLDMTKNiJNSxpFhjNgNZUTuHQs4QjBHJitlbEhlKe9Hk0w/viewform");
    
    @IBOutlet var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = URLRequest(url: url!);
        webView.loadRequest(request);

        navigationController?.navigationBar.topItem?.title = NSLocalizedString("Research Form", comment: "")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.topItem?.title = NSLocalizedString("Research Form", comment: "")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
