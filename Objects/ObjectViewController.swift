//
//  ObjectViewController.swift
//  Objects
//
//  Created by Sashank Gogula on 10/25/15.
//  Copyright © 2015 sashankg. All rights reserved.
//

import Foundation
import UIKit

class ObjectViewController: UIViewController {
	
	@IBOutlet weak var topConstraint: NSLayoutConstraint!
	@IBOutlet weak var bottomContstraint: NSLayoutConstraint!
	
	override func viewWillAppear(animated: Bool) {
		topConstraint.constant = -64 - 24
		bottomContstraint.constant = -44
		view.layoutIfNeeded()
		print(parentViewController)
	}
	
	override func viewDidAppear(animated: Bool) {
		self.topConstraint.constant = 0 - 24
		bottomContstraint.constant = 0
		UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut , animations: {
			self.view.layoutIfNeeded()
			}, completion: nil)
	}
	
	@IBAction func backButtonPressed(sender: AnyObject) {
		topConstraint.constant = -64 - 24
		bottomContstraint.constant = -44
		UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn , animations: {
			self.view.layoutIfNeeded()
			}) { _ in self.dismissViewControllerAnimated(false, completion: nil) }
	}
	
	@IBAction func pinchToClose(sender: UIPinchGestureRecognizer) {
		/*if sender.state == .Moved
		{
			
		}*/
	}
}