//
//  RestManager.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 3/19/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class RestManager {
    
    static let IP = "https://previna-avc-server.azurewebsites.net"
    static let PORT = ":8081"
    static let ENDPOINT = "/rest"
    //static let REST_ENDPOINT = IP + PORT + ENDPOINT
    static let REST_ENDPOINT = IP + ENDPOINT
    
    static let instance = RestManager()
    
    func calculateRiskForPerson(person: Person, completion: @escaping (Bool) -> ()) {
        
        let endpoint = RestManager.REST_ENDPOINT + "/calculateRiskForPerson"
 
        let jsonPerson = JSON(person.dictionaryRepresentation())
        
        print("Sending: \(jsonPerson)")
        
        let headers =
            ["Content-Type" : "application/json",
             "Accept": "application/json"]
        
        //    public func encode(_ urlRequest: URLRequestConvertible, withJSONObject jsonObject: Any? = nil) throws -> URLRequest {
        Alamofire.request(endpoint, method: .post, parameters: person.dictionaryRepresentation(), encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            
            switch (response.result) {
                
            case .success:
                if let result = response.result.value {
                    let json = JSON(result)
                    let person = Person(json: json)
                    UserManager.instance.person = person
                    completion(true)
                }
            case .failure:
                print(response.error!)
                print(response.data!)
                print(response.debugDescription)
                print(response.description)
                print(response.result)
                //print(response.result.value!)
                print("REST Failure @ \(endpoint) with parameter \(person.dictionaryRepresentation()).")
                completion(false)
            }

        }
        
    }
    
    func getRiskLevel(name: String, completion: @escaping (String) -> ()) {
        
        let endpoint = RestManager.REST_ENDPOINT + "/getRiskLevel"
        
        let parameter = ["name":name]
        
        Alamofire.request(endpoint, method: .get, parameters: parameter).responseJSON { response in
            
            switch (response.result) {
                
            case .success:
                let risk = String(describing: response.result.value) //  as! NSDecimalNumber
                completion(risk)
            case .failure:
                let risk = "?"
                print("REST Failure @ \(endpoint) with parameter \(parameter). Returning \(risk)")
                completion(risk)
            }
            
        }
    }
    
}
