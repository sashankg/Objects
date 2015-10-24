//
//  ObjectModel.swift
//  Objects
//
//  Created by Sashank Gogula on 10/23/15.
//  Copyright © 2015 sashankg. All rights reserved.
//

import Foundation
import CloudKit

protocol Value {
	func type() -> ValueType
	func toCKRecordValue() -> CKRecordValue
}

struct Object: Value {
	
	private var dictionary: [String: Value]
	private var id: String
	init()
	{
		dictionary = [String: Value]()
		id = NSUUID().UUIDString
	}
	
	subscript(key: String) -> Value?
	{
		get { return dictionary[key] }
		set(newValue) { dictionary[key] = newValue }
	}
	
	var keys: [String] {
		return dictionary.keys.flatMap { return $0 }
	}
	
	func type() -> ValueType {
		return .Object
	}
	
	func toCKRecordValue() -> CKRecordValue {
		return CKReference(recordID: CKRecordID(recordName: id), action: .DeleteSelf)
	}
}

enum ValueType
{
	case Text, Number, Object, Other
	
	func toString() -> String
	{
		switch self {
		case .Text: return "Text"
		case .Number: return "Number"
		default: return ""
		}
	}
}


