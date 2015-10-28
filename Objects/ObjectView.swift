//
//  ObjectView.swift
//  Objects
//
//  Created by Sashank Gogula on 10/24/15.
//  Copyright © 2015 sashankg. All rights reserved.
//

import Foundation
import UIKit
class ObjectView: UIView {
	
	private var color: UIColor?
	override var backgroundColor: UIColor?
		{
		get { return color }
		set(newValue) {
			color = newValue
			setNeedsDisplay()
		}
	}
	
	var storedFrame: CGRect!
	var isAnimating: Bool!
	var controller: ViewController!
	override func drawRect(rect: CGRect) {
		let cr = UIGraphicsGetCurrentContext()
		CGContextSetFillColorWithColor(cr, color?.CGColor)
		CGContextFillEllipseInRect(cr, rect)
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		initialize()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		initialize()
	}
	
	func initialize()
	{
		super.backgroundColor = UIColor.clearColor()
		isAnimating = false
		let button = UIButton(frame: CGRectMake(0, 0, frame.width, frame.height))
		addSubview(button)
		button.addTarget(self, action: "fillSuperview:", forControlEvents: .TouchUpInside)
	}
	
	func fillSuperview(sender: UIButton)
	{
		storedFrame = frame
		superview?.bringSubviewToFront(self)
		superview?.userInteractionEnabled = false
		controller.hideToolBar()
		controller.openedObject = self
		let r = sqrt((superview!.frame.width*superview!.frame.width) + (superview!.frame.height*superview!.frame.height))/2;
		UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
			self.frame = CGRectMake((self.superview!.frame.width/2)-r, (self.superview!.frame.height/2)-r, 2*r, 2*r)
			}, completion: { _ in
				self.controller.performSegueWithIdentifier("toObjectViewController", sender: self)
		})
	}
	
	func shrinkBack()
	{
		controller.showToolBar()
		UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
			self.frame = self.storedFrame
			},
			completion: { _ in
				self.superview?.userInteractionEnabled = true
		})
	}
}