//  ViewController.swift
//  All-The-Weathers
//  Created by Peter Foti on 10/19/15.
//  Copyright © 2015 Peter Foti. All rights reserved.

import UIKit

final class MainViewController: UIViewController {
    
    @IBOutlet weak private var cityStateLabel: UILabel!
    @IBOutlet weak private var currentTempLabel: UILabel!
    
    let animationDuration: NSTimeInterval = 0.8
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LocationManager.sharedInstance.addObserver(self, forKeyPath: "currentLocation", options: [.New, .Old], context: nil)
        LocationManager.sharedInstance.updateLocation()
        cityStateLabel.animateTextUpdate("Updating Current Location", animationDuration: animationDuration)
    }
    
    func configureWithLocation(currentLocation: Location) {
        cityStateLabel.animateTextUpdate(currentLocation.cityAndState, animationDuration: animationDuration)
        OpenWeatherMapNetworkCommunicator.sharedInstance.fetchCurrentWeather(currentLocation) { (weatherObjects) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.currentTempLabel.animateTextUpdate(weatherObjects!.last!.temperatureString, animationDuration: self.animationDuration)
            })
        }
        
        OpenWeatherMapNetworkCommunicator.sharedInstance.fetchFiveDayWeatherForecast(currentLocation) { (weatherObjects) -> Void in
        }
    }
    
    deinit {
        LocationManager.sharedInstance.removeObserver(self, forKeyPath: "currentLocation")
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if let change = change {
            configureWithLocation(change["new"] as! Location)
        } else {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
    }
}
