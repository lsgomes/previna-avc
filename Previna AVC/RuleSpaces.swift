//
//  RuleSpaces.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 4/26/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

import Foundation
import Eureka

public struct RuleSpaces<T: Equatable>: RuleType {
    
    public init(msg: String = "Digite apenas seu primeiro nome."){
        self.validationError = ValidationError(msg: msg)
    }
    
    public var id: String?
    public var validationError: ValidationError
    
    public func isValid(value: T?) -> ValidationError? {
        if let str = value as? String {
            
            return str.contains(" ") ? validationError : nil
        }
        return value != nil ? nil : validationError
    }
}
