//
//  ObjectModel.swift
//  Objects
//
//  Created by Sashank Gogula on 10/23/15.
//  Copyright © 2015 sashankg. All rights reserved.
//

import Foundation

struct Object {
	
	private var dictionary: [String: Value]
	
	subscript(key: String) -> Value?
	{
		get { return dictionary[key] }
		set(newValue) { dictionary[key] = newValue }
	}
	
	var keys: [String] {
		return dictionary.keys.flatMap { return $0 }
	}
}

enum ValueType
{
	case Text, Number, Other
	
	func toString() -> String
	{
		switch self {
		case .Text: return "Text"
		case .Number: return "Number"
		default: return ""
		}
	}
}

protocol Value {
	func type() -> ValueType
}

