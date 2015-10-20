//  Location.swift
//  All-The-Weathers
//  Created by Peter Foti on 10/19/15.
//  Copyright © 2015 Peter Foti. All rights reserved.

import Foundation
import CoreLocation

final class Location: NSObject {
    var city: String?
    var state: String?
    var cityAndState: String {
        get {
            if let city = city, state = state {
                return "\(city), \(state)"
            } else {
                return ""
            }
        }
    }
    
    convenience init(placemark: CLPlacemark) {
        self.init()
        self.city = placemark.locality!
        self.state = placemark.administrativeArea!
    }
}
