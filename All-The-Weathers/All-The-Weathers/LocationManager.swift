//  LocationManager.swift
//  All-The-Weathers
//  Created by Peter Foti on 10/19/15.
//  Copyright © 2015 Peter Foti. All rights reserved.

import Foundation
import CoreLocation

final class LocationManager: NSObject {
    
    static let sharedInstance = LocationManager()
    
    dynamic var currentLocation: Location?
    
    private lazy var cllocationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        return locationManager
    }()
    
    func updateLocation() {
        cllocationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        cllocationManager.stopUpdatingLocation()
        CLGeocoder().reverseGeocodeLocation(locations.last!) { (placemarks, error) -> Void in
            if let placemark = placemarks?[0] {
                self.currentLocation = Location(city: placemark.locality!, state: placemark.administrativeArea!)
            }
        }
    }
}