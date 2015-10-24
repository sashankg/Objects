//
//  InfiniteScrollView.swift
//  Objects
//
//  Created by Sashank Gogula on 10/24/15.
//  Copyright © 2015 sashankg. All rights reserved.
//

import Foundation
import UIKit
class InfiniteScrollView: UIScrollView, UIScrollViewDelegate {
	
	var views = [[UIView]]()
	var yViews = [[UIView]]()
	var size: CGFloat = 100
	var space: CGFloat = 50
	
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
		contentSize = CGSizeMake(frame.width + 1, frame.height + 1)
		delegate = self
		
		for i in 0...5
		{
			views.append([UIView]())
			for j in 0...5
			{
				let x = CGFloat(i) * (size + space) + CGFloat(j%2) * (size + space)/2
				let y = CGFloat(j) * (size + space)
				let v = UIView(frame: CGRectMake(x, y, size, size))
				v.layer.cornerRadius = size/2
				v.backgroundColor = UIColor(red: CGFloat(i)/5, green: 0.0, blue: CGFloat(j)/5, alpha: 1.0)
				addSubview(v)
				views[i].append(v)
			}
		}
		for i in 0...views.count-1
		{
			yViews.append([UIView]())
			for j in 0...views[i].count-1
			{
				yViews[i].append(views[j][i])
			}
		}
	}
	
	func scrollViewDidScroll(scrollView: UIScrollView) {
		if scrollView.contentOffset.x < 0 && views[views.count-1][0].frame.origin.x > frame.width
		{
			var shift: CGFloat = 0
			for i in 0...views[views.count-1].count-1
			{
				views[views.count-1][i].frame.origin.x = views[0][0].frame.origin.x - size - space + (shift%2) * (size + space)/2
				shift += 1
			}
			views.insert(views.removeLast(), atIndex: 0)
		}
		else if scrollView.contentOffset.x > 0 && views[0][1].frame.origin.x + size + space < 0
		{
			var shift: CGFloat = 0
			for i in 0...views[0].count-1
			{
				views[0][i].frame.origin.x = views[views.count-1][0].frame.origin.x + space + size + (shift%2) * (size + space)/2
				shift += 1
			}
			views.insert(views.removeFirst(), atIndex: views.count)
		}
		
		if scrollView.contentOffset.y < 0 && yViews[yViews.count-1][0].frame.origin.y > frame.height
		{
			for i in 0...yViews[yViews.count-1].count-1
			{
				yViews[yViews.count-1][i].frame.origin.y = yViews[0][0].frame.origin.y - size - space			}
			yViews.insert(yViews.removeLast(), atIndex: 0)
		}
		else if scrollView.contentOffset.y > 0 && yViews[0][1].frame.origin.y + size + space < 0
		{
			for i in 0...yViews[0].count-1
			{
				yViews[0][i].frame.origin.y = yViews[yViews.count-1][0].frame.origin.y + space + size
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
}
