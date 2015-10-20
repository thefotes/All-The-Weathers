//  WeatherTableViewCell.swift
//  All-The-Weathers
//  Created by Peter Foti on 10/19/15.
//  Copyright © 2015 Peter Foti. All rights reserved.

import UIKit

final class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var dayOfWeekLabel: UILabel!
    @IBOutlet weak private var temperatureLabel: UILabel!
    
    private let animationDuration = 0.5
    
    func configureWithWeather(weather: Weather) {
        dayOfWeekLabel.animateTextUpdate(weather.dayOfWeek, animationDuration: animationDuration)
        temperatureLabel.animateTextUpdate(weather.temperatureString, animationDuration: animationDuration)
    }
}
