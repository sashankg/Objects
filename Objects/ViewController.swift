//
//  ViewController.swift
//  Objects
//
//  Created by Sashank Gogula on 10/17/15.
//  Copyright © 2015 sashankg. All rights reserved.
//

import UIKit
import Interstellar

class ViewController: UIViewController, UIScrollViewDelegate {
	
	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var bottomConstraint: NSLayoutConstraint!
	
	var views = [[ObjectView]]()
	var yViews = [[ObjectView]]()
	var size: CGFloat = 100
	var space: CGFloat = 50
	
	var openedObject: ObjectView?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationController?.navigationBarHidden = true
		scrollView.contentSize = CGSizeMake(view.frame.width + 1, view.frame.height + 1)
		let screen = UIScreen.mainScreen().bounds
		for i in 0...5
		{
			views.append([ObjectView]())
			for j in 0...5
			{
				let x = CGFloat(i) * (size + space) + CGFloat(j%2) * (size + space)/2 + screen.width/2 - size/2
				let y = CGFloat(j) * (size + space) + screen.height/2 - size/2
				let v = ObjectView(frame: CGRectMake(x, y, size, size), controller: self)
				v.backgroundColor = UIColor(red: CGFloat(j + i + 2)/15, green: 0, blue: 1, alpha: 1.0)
				scrollView.addSubview(v)
				views[i].append(v)
			}
		}
		for i in 0...views.count-1
		{
			yViews.append([ObjectView]())
			for j in 0...views[i].count-1
			{
				yViews[i].append(views[j][i])
			}
		}
		scrollView.contentOffset = CGPointMake(-1, -1)
		scrollViewDidScroll(scrollView)
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		if let object = openedObject
		{
			object.shrinkBack()
		}
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		let object = sender as! ObjectView
		if let destination = segue.destinationViewController as? ObjectViewController
		{
			destination.view.backgroundColor = object.backgroundColor
		}
	}
	
	func scrollViewDidScroll(scrollView: UIScrollView) {
		func animateViewEntrance(view: ObjectView)
		{
			if view.isAnimating == true { return }
			let f = view.frame
			view.frame = CGRectMake(f.origin.x + f.width/2, f.origin.y + f.height/2, 0, 0)
			view.isAnimating = true
			UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
				view.frame = f
				}, completion: { _ in view.isAnimating = false })
		}
		
		if scrollView.contentOffset.x < 0 && views.last![0].frame.origin.x > view.frame.width
		{
			var shift: CGFloat = 0
			for i in 0...views.last!.count-1
			{
				let offset = (shift%2) * (size + space)/2
				views[views.count-1][i].frame.origin.x = views[0][0].frame.origin.x - size - space + offset
				if views[views.count-1][i].frame.origin.x + size + space + offset > 0
				{
					animateViewEntrance(views[views.count-1][i])
				}
				shift += 1
			}
			views.insert(views.removeLast(), atIndex: 0)
		}
		else if scrollView.contentOffset.x > 0 && views[0][1].frame.origin.x + size + space < 0
		{
			var shift: CGFloat = 0
			for i in 0...views[0].count-1
			{
				views[0][i].frame.origin.x = views.last![0].frame.origin.x + space + size + (shift%2) * (size + space)/2
				if views[0][i].frame.origin.x < view.frame.width
				{
					animateViewEntrance(views[0][i])
				}
				shift += 1
			}
			views.insert(views.removeFirst(), atIndex: views.count)
		}
		
		if scrollView.contentOffset.y < 0 && yViews.last![0].frame.origin.y > view.frame.height
		{
			for i in 0...yViews.last!.count-1
			{
				yViews.last![i].frame.origin.y = yViews[0][0].frame.origin.y - size - space
				if yViews.last![i].frame.origin.y + size > 0
				{
					animateViewEntrance(yViews[yViews.count-1][i])
				}
			}
			yViews.insert(yViews.removeLast(), atIndex: 0)
		}
		else if scrollView.contentOffset.y > 0 && yViews[0][1].frame.origin.y + size < 0
		{
			for i in 0...yViews[0].count-1
			{
				yViews[0][i].frame.origin.y = yViews.last![0].frame.origin.y + space + size
				if yViews[0][i].frame.origin.y < view.frame.height
				{
					animateViewEntrance(yViews[0][i])
				}
			}
			yViews.insert(yViews.removeFirst(), atIndex: yViews.count)
		}
		
		for i in 0...yViews.count-1
		{
			for j in 0...yViews[i].count-1
			{
				let s = yViews[i][j]
				yViews[i][j].frame.origin = CGPointMake(s.frame.origin.x - scrollView.contentOffset.x, s.frame.origin.y - scrollView.contentOffset.y)
			}
		}
		scrollView.contentOffset = CGPointMake(0, 0)
	}
	
	func hideToolBar()
	{
		bottomConstraint.constant = -44
		UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveEaseOut, animations: { () -> Void in
			self.view.layoutIfNeeded()
			}, completion: nil)
	}
	
	func showToolBar()
	{
		bottomConstraint.constant = 0
		UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveEaseOut, animations: { () -> Void in
			self.view.layoutIfNeeded()
			}, completion: nil)
	}
	
	@IBAction func newObjectButton(sender: AnyObject) {
		let frame = UIScreen.mainScreen().bounds
		let new = ObjectView(frame: CGRectMake(frame.width/2 - 50, frame.height + 100, 100, 100), controller: self)
		new.transform = CGAffineTransformMakeScale(0.1, 0.1)
		view.addSubview(new)
		UIView.animateWithDuration(0.4, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
				new.frame.origin.y = frame.height/2 - 5
				new.transform = CGAffineTransformMakeScale(1, 1)

			}) { (_) -> Void in
				new.fillSuperview()
		}
		
	}
}

