//
//  Util.swift
//  Objects
//
//  Created by Sashank Gogula on 11/21/15.
//  Copyright © 2015 sashankg. All rights reserved.
//

import Foundation
import UIKit
import Interstellar

var TypingSignalHandle: UInt8 = 0
extension UITextField
{
	public var textSignal: Signal<String> {
		let signal: Signal<String>
		if let handle = objc_getAssociatedObject(self, &TypingSignalHandle) as? Signal<String> {
			signal = handle
		} else {
			signal = Signal()
			addTarget(self, action: "updateText:", forControlEvents: .AllEditingEvents)
			objc_setAssociatedObject(self, &TypingSignalHandle, signal, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
		return signal
	}
	
	private func updateText(textField: UITextField)
	{
		textSignal.update(textField.text!)
	}
}

var ButtonSignalHandle: UInt8 = 0
extension UIButton
{
	private var pressSignal: Signal<UIButton> {
		let signal: Signal<UIButton>
		if let handle = objc_getAssociatedObject(self, &ButtonSignalHandle) as? Signal<UIButton> {
			signal = handle
		} else {
			signal = Signal()
			addTarget(self, action: "touch:", forControlEvents: .TouchUpInside)
			objc_setAssociatedObject(self, &ButtonSignalHandle, signal, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
		return signal
	}
	
	public func touch(button: UIButton)
	{
		pressSignal.update(button)
	}
	
	public func perfromWhenTouched(closure: () -> Void)
	{
		pressSignal.next { _ in
			closure()
		}
	}
}