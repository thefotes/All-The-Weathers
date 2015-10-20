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
            formatter.dateFormat = "EEEE"
            return formatter.stringFromDate(self.dateOfRecord)
        }
    }
    
    private lazy var formatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        
        return formatter
    }()
    
    convenience init(jsonDict: NSDictionary) {
        self.init()
        self.currentTemperature = (jsonDict["main"] as! NSDictionary)["temp"] as! Int
        self.formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        self.dateOfRecord = formatter.dateFromString(jsonDict["dt_txt"] as! String)
    }
}
