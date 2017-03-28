//
//  Person.swift
//
//  Created by Lucas Dos Santos Gomes on 3/23/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Person: NSObject, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let hasDevice = "hasDevice"
    static let uri = "uri"
    static let hasRiskLevel = "hasRiskLevel"
    static let hasRiskFactor = "hasRiskFactor"
    static let hasAge = "hasAge"
    static let hasPassword = "hasPassword"
    static let hasUserName = "hasUserName"

  }

  // MARK: Properties
  public var hasDevice: [HasDevice]?
  public var uri: String?
  public var hasRiskLevel: Int?
  public var hasRiskFactor: [HasRiskFactor]?
  public var hasAge: Int?
  public var hasPassword: String?
  public var hasUserName: String?

  
    
    
  //MARK: Archiving Paths
  static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
  static let ArchiveURL = DocumentsDirectory.appendingPathComponent("person")


  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    if let items = json[SerializationKeys.hasDevice].array { hasDevice = items.map { HasDevice(json: $0) } }
    uri = json[SerializationKeys.uri].string
    hasRiskLevel = json[SerializationKeys.hasRiskLevel].int
    if let items = json[SerializationKeys.hasRiskFactor].array { hasRiskFactor = items.map { HasRiskFactor(json: $0) } }
    hasAge = json[SerializationKeys.hasAge].int
    hasPassword = json[SerializationKeys.hasPassword].string
    hasUserName = json[SerializationKeys.hasUserName].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = hasDevice { dictionary[SerializationKeys.hasDevice] = value.map { $0.dictionaryRepresentation() } }
    if let value = uri { dictionary[SerializationKeys.uri] = value }
    if let value = hasRiskLevel { dictionary[SerializationKeys.hasRiskLevel] = value }
    if let value = hasRiskFactor { dictionary[SerializationKeys.hasRiskFactor] = value.map { $0.dictionaryRepresentation() } }
    if let value = hasAge { dictionary[SerializationKeys.hasAge] = value }
    if let value = hasPassword { dictionary[SerializationKeys.hasPassword] = value }
    if let value = hasUserName { dictionary[SerializationKeys.hasUserName] = value }

    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.hasDevice = aDecoder.decodeObject(forKey: SerializationKeys.hasDevice) as? [HasDevice]
    self.uri = aDecoder.decodeObject(forKey: SerializationKeys.uri) as? String
    self.hasRiskLevel = aDecoder.decodeObject(forKey: SerializationKeys.hasRiskLevel) as? Int
    self.hasRiskFactor = aDecoder.decodeObject(forKey: SerializationKeys.hasRiskFactor) as? [HasRiskFactor]
    self.hasAge = aDecoder.decodeObject(forKey: SerializationKeys.hasAge) as? Int
    self.hasPassword = aDecoder.decodeObject(forKey: SerializationKeys.hasPassword) as? String
    self.hasUserName = aDecoder.decodeObject(forKey: SerializationKeys.hasUserName) as? String

  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(hasDevice, forKey: SerializationKeys.hasDevice)
    aCoder.encode(uri, forKey: SerializationKeys.uri)
    aCoder.encode(hasRiskLevel, forKey: SerializationKeys.hasRiskLevel)
    aCoder.encode(hasRiskFactor, forKey: SerializationKeys.hasRiskFactor)
    aCoder.encode(hasAge, forKey: SerializationKeys.hasAge)
    aCoder.encode(hasPassword, forKey: SerializationKeys.hasPassword)
    aCoder.encode(hasUserName, forKey: SerializationKeys.hasUserName)
  }

  public override init() { super.init() }
}
