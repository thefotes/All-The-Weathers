//  Weather.swift
//  All-The-Weathers
//  Created by Peter Foti on 10/19/15.
//  Copyright © 2015 Peter Foti. All rights reserved.

import Foundation

final class Weather {
    var currentTemperature: Int!
    var dateOfRecord: NSDate!
    var temperatureString: String {
        get {
            return "\(self.currentTemperature)°"
        }
    }
    
    var dayOfWeek: String {
        get {
            return self.formatter.stringFromDate(self.dateOfRecord)
        }
    }
    
    private lazy var formatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEEE"
        
        return formatter
    }()
}
