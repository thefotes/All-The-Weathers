//  WeatherTableViewCell.swift
//  All-The-Weathers
//  Created by Peter Foti on 10/19/15.
//  Copyright © 2015 Peter Foti. All rights reserved.

import UIKit

final class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var dayOfWeekLabel: UILabel!
    @IBOutlet weak private var temperatureLabel: UILabel!
    
    func configureWithWeather(weather: Weather) {
        dayOfWeekLabel.text = weather.dayOfWeek
        temperatureLabel.text = weather.temperatureString
    }
}
