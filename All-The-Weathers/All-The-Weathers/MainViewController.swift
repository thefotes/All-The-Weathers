//  ViewController.swift
//  All-The-Weathers
//  Created by Peter Foti on 10/19/15.
//  Copyright © 2015 Peter Foti. All rights reserved.

import UIKit

final class MainViewController: UIViewController {
    
    @IBOutlet weak private var cityStateLabel: UILabel!
    
    let animationDuration: NSTimeInterval = 0.8
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LocationManager.sharedInstance.addObserver(self, forKeyPath: "currentLocation", options: [.New, .Old], context: nil)
        LocationManager.sharedInstance.updateLocation()
        cityStateLabel.animateTextUpdate("Updating Current Location", animationDuration: animationDuration)
    }
    
    func configureWithLocation(currentLocation: Location) {
        cityStateLabel.animateTextUpdate(currentLocation.cityAndState, animationDuration: animationDuration)
    }
    
    deinit {
        LocationManager.sharedInstance.removeObserver(self, forKeyPath: "currentLocation")
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if let change = change {
            configureWithLocation(change["new"] as! Location)
        }
    }
}
