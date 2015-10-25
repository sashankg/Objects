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
	var hovering: Bool!
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
		button.backgroundColor = UIColor.purpleColor()
		button.alpha = 0.3
		addSubview(button)
		button.addTarget(self, action: "hover:", forControlEvents: .TouchDown)
		button.addTarget(self, action: "land:", forControlEvents: .TouchDragInside)
		button.addTarget(self, action: "fillSuperview:", forControlEvents: .TouchUpInside)
	}
	
	func fillSuperview(sender: UIButton)
	{
		if hovering == true
		{
			storedFrame = frame
			superview?.bringSubviewToFront(self)
			superview?.userInteractionEnabled = false
			let r = sqrt((superview!.frame.width*superview!.frame.width) + (superview!.frame.height*superview!.frame.height))/2;
			UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
				self.frame = CGRectMake((self.superview!.frame.width/2)-r, (self.superview!.frame.height/2)-r, 2*r, 2*r)
				}, completion: { _ in
					self.superview?.userInteractionEnabled = true
					self.controller.performSegueWithIdentifier("toObjectViewController", sender: self)
			})
		}
	}
	
	func hover(sender: UIButton)
	{
		hovering = true
		let f = self.frame
		UIView.animateWithDuration(0.1, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
			self.frame = CGRectMake(f.origin.x-10, f.origin.y-10, f.width+20, f.height+20)
			sender.frame.size = self.frame.size
			}, completion: nil)
	}
	
	func land(sender: UIButton)
	{
		if hovering == true
		{
			hovering = false
			let f = self.frame
			UIView.animateWithDuration(0.1, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
				self.frame = CGRectMake(f.origin.x+10, f.origin.y+10, f.width-20, f.height-20)
				sender.frame.size = self.frame.size
				
				}, completion: { _ in self.hovering = false})
		}
	}
}