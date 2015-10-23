//
//  ObjectPreview.swift
//  Objects
//
//  Created by Sashank Gogula on 10/18/15.
//  Copyright © 2015 sashankg. All rights reserved.
//

import Foundation
import UIKit
import ReactiveCocoa

class ObjectPreview: UIView {
	
	
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		initialize()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		initialize()
	}
	
	func initialize()
	{
		
		backgroundColor = UIColor.greenColor()
		let view = UIView(frame: CGRectMake(0, 0, 50, 50))
		view.backgroundColor = UIColor.greenColor()
		addSubview(view)
		
		UIView.animateWithDuration(10) { () -> Void in
			self.frame = CGRectMake(0, 0, 10, 10)
		}
	}
	
	
}