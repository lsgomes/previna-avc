//
//  HasRiskFactor.swift
//
//  Created by Lucas Dos Santos Gomes on 3/23/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class HasRiskFactor: NSObject, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let uri = "uri"
    static let hasWeight = "hasWeight"
  }

  // MARK: Properties
  public var uri: String?
  public var hasWeight: Int?

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
    uri = json[SerializationKeys.uri].string
    hasWeight = json[SerializationKeys.hasWeight].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = uri { dictionary[SerializationKeys.uri] = value }
    if let value = hasWeight { dictionary[SerializationKeys.hasWeight] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.uri = aDecoder.decodeObject(forKey: SerializationKeys.uri) as? String
    self.hasWeight = aDecoder.decodeObject(forKey: SerializationKeys.hasWeight) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(uri, forKey: SerializationKeys.uri)
    aCoder.encode(hasWeight, forKey: SerializationKeys.hasWeight)
  }
  
  public override init() { super.init() }

}
