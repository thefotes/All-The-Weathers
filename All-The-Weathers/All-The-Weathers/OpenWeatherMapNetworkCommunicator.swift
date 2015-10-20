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
    
    typealias NetworkCompletionBlock = ([Weather]?) -> Void
   
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
    
    func fetchCurrentWeather(location: Location, completionBlock: (result: [Weather]?) -> Void) {
        let url = currentWeatherURL(location)
        session.dataTaskWithURL(url) { (data, response, error) -> Void in
            let weather = Weather()
            let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: []) as! NSDictionary
            weather.currentTemperature = (json["main"] as! NSDictionary)["temp"] as! Int
            weather.dateOfRecord = NSDate()
            completionBlock(result: [weather])
        }.resume()
    }
    
    func fetchFiveDayWeatherForecast(location: Location, completionBlock: NetworkCompletionBlock) {
        let url = fiveDayRequestForLocation(location)
        session.dataTaskWithURL(url) { (data, response, error) -> Void in
            let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: [])
            print(json)
        }.resume()
    }
}
