//
//  ViewController.swift
//  Objects
//
//  Created by Sashank Gogula on 10/17/15.
//  Copyright © 2015 sashankg. All rights reserved.
//

import UIKit
import ReactiveCocoa

class ViewController: UIViewController {

	var scrollView: InfiniteScrollView!
	
	override func viewDidLoad() {
		super.viewDidLoad()

	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		// Do any additional setup after loading the view, typically from a nib.
		
		scrollView = InfiniteScrollView(frame: CGRectMake(0, 0, view.frame.width, view.frame.height))
		view.addSubview(scrollView)
		//scrollView.contentOffset = CGPointMake(r.width, r.height)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

