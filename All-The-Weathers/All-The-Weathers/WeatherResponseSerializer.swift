//  WeatherResponseSerializer.swift
//  All-The-Weathers
//  Created by Peter Foti on 10/20/15.
//  Copyright © 2015 Peter Foti. All rights reserved.

import Foundation

final class WeatherResponseSerializer {
    
    private lazy var formatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        
        return formatter
        }()
    
    class func weatherObjectsFromDict(jsonDict: NSDictionary) -> [Weather] {
        let weatherObjectsList = jsonDict["list"] as! NSArray
        let weatherObjects = weatherObjectsList.map({ return Weather(jsonDict: $0 as! NSDictionary) })
        let filteredObjects = weatherObjects.filter({ WeatherResponseSerializer().formatter.stringFromDate($0.dateOfRecord) == "12:00:00" })
        
        return filteredObjects
    }
}
