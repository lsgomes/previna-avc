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

        navigationController?.navigationBar.topItem?.title = "Formulário de pesquisa"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.topItem?.title = "Formulário de pesquisa"

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
