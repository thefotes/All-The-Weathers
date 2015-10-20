//  OpenWeatherMapNetworkCommunicator.swift
//  All-The-Weathers
//  Created by Peter Foti on 10/19/15.
//  Copyright © 2015 Peter Foti. All rights reserved.

import Foundation

final class OpenWeatherMapNetworkCommunicator {
    static let sharedInstance = OpenWeatherMapNetworkCommunicator()
    
    private let apiKey = "2396eb96d647aeb6d98bedb4920e8b24"
    
    private lazy var session: NSURLSession = {
        return NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    }()
    
    typealias FiveDayRequestCompletionBlock = (fiveDayForecast: [Weather]?) -> Void
    typealias WeatherDataCompletionBlock = (todaysWeather: Weather?, fiveDayForecast: [Weather]?) -> Void
    
    private func urlEncodedCity(rawCity: String) -> String {
        return rawCity.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
    }
    
    private func fiveDayRequestForLocation(location: Location) -> NSURL {
        let urlString = "http://api.openweathermap.org/data/2.5/forecast?q=\(urlEncodedCity(location.city!)),USA&units=imperial&appid=\(apiKey)"
        return NSURL(string: urlString)!
    }
    
    private func currentWeatherURL(location: Location) -> NSURL {
        let urlString = "http://api.openweathermap.org/data/2.5/weather?q=\(urlEncodedCity(location.city!)),USA&units=imperial&appid=\(apiKey)"
        return NSURL(string: urlString)!
    }
    
    func fetchCurrentWeather(location: Location, completionBlock: (result: Weather?) -> Void) {
        let url = currentWeatherURL(location)
        session.dataTaskWithURL(url) { (data, response, error) -> Void in
            let weather = Weather()
            let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: []) as! NSDictionary
            weather.currentTemperature = (json["main"] as! NSDictionary)["temp"] as! Int
            weather.dateOfRecord = NSDate()
            completionBlock(result: weather)
        }.resume()
    }
    
    func fetchFiveDayWeatherForecast(location: Location, completionBlock: FiveDayRequestCompletionBlock) {
        let url = fiveDayRequestForLocation(location)
        session.dataTaskWithURL(url) { (data, response, error) -> Void in
            let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: []) as! NSDictionary
            let weatherObjects = WeatherResponseSerializer.weatherObjectsFromDict(json)
            completionBlock(fiveDayForecast: weatherObjects)
        }.resume()
    }
    
    func fetchWeatherData(location: Location, completionBlock: WeatherDataCompletionBlock) {
        let weatherRequestGroup = dispatch_group_create()
        var currentWeather: Weather?
        dispatch_group_enter(weatherRequestGroup)
        fetchCurrentWeather(location) { (result) -> Void in
            currentWeather = result
            dispatch_group_leave(weatherRequestGroup)
        }
        
        var fiveDayWeather: [Weather]?
        dispatch_group_enter(weatherRequestGroup)
        fetchFiveDayWeatherForecast(location) { (fiveDayForecast) -> Void in
            fiveDayWeather = fiveDayForecast
            dispatch_group_leave(weatherRequestGroup)
        }
        
        dispatch_group_notify(weatherRequestGroup, dispatch_get_main_queue()) { () -> Void in
            completionBlock(todaysWeather: currentWeather, fiveDayForecast: fiveDayWeather)
        }
    }
}
