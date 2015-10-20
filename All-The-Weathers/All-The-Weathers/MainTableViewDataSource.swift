//  MainTableViewDataSource.swift
//  All-The-Weathers
//  Created by Peter Foti on 10/19/15.
//  Copyright © 2015 Peter Foti. All rights reserved.

import UIKit

final class MainTableViewDataSource: NSObject, UITableViewDataSource {
  
    var weatherData: [Weather] = []
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(NibNames.WeatherTableViewCell.rawValue) as! WeatherTableViewCell
        cell.configureWithWeather(weatherData[indexPath.row])
        
        return cell
    }
}
