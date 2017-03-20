//
//  RestManager.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 3/19/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

import Foundation
import Alamofire

class RestManager {
    
    static let IP = "http://192.168.25.49"
    static let PORT = ":8081"
    static let ENDPOINT = "/rest"
    static let REST_ENDPOINT = IP + PORT + ENDPOINT
    
    static let instance = RestManager()
    
    func getRiskLevel(name: String, completion: @escaping (String) -> ()) {
        
        let endpoint = RestManager.REST_ENDPOINT + "/getRiskLevel"
        
        let parameter = ["name":name]
        
        Alamofire.request(endpoint, method: .get, parameters: parameter).responseJSON { response in
            
            switch (response.result) {
                
            case .success:
                let risk = String(describing: response.result.value as! NSDecimalNumber)
                completion(risk + "%")
            case .failure:
                let risk = "?"
                print("REST Failure @ \(endpoint) with parameter \(parameter). Returning \(risk)")
                completion(risk)
            }
            
        }
    }
    
}
