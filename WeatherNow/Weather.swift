//
//  Weather.swift
//  WeatherNow
//
//  Created by Yong Jae Kim on 2015. 11. 27..
//  Copyright © 2015년 Yong Jae Kim. All rights reserved.
//

import Foundation
import Alamofire

class Weather {
    private var _temperature: String!
    private var _humidity: String!
    private var _windSpeed: String!
    private var _weatherState: String!
    private var _dayId: Int!
    
    var weatherState: String {
        if let state = _weatherState {
            return state
        } else {
            return "Sun"
        }
    }
    
    var temperature: String {
        if let temp = _temperature {
            return temp
        } else {
            return "0"
        }
    }
    
    var humidity: String {
        if let humid = _humidity {
            return humid
        } else {
            return "0"
        }
    }
    
    var windSpeed: String {
        if let speed = _windSpeed {
            return speed
        } else {
            return "0"
        }
    }
    
    var dayId: Int {
        return _dayId
    }
    
    init (dayId: Int) {
        self._dayId = dayId
    }
    
    func downloadWeatherData(completed: DownloadComplete) {
        let url = NSURL(string: URL_DEFAULT)!
        
        Alamofire.request(.GET, url, parameters: ["q" : "Seoul", "appid" : "4e095de545b0efd12556be0a828ae5bc", "mode" : "json", "units" : "metric"]).responseJSON { (response) in
            let result = response.result
            
            
            if let dict = result.value as? Dictionary<String,AnyObject> {
                if let list = dict["list"] as? [Dictionary<String,AnyObject>] {
                    print("dayId : \(self._dayId)")
                    if let main = list[self._dayId]["main"] as? Dictionary<String,AnyObject> {
                        if let temp = main["temp"] {
                            
                            self._temperature = "\((temp as! Int))"
                            print(self._temperature)
                        }
                        
                        if let humid = main["humidity"] {
                            self._humidity = "\(humid)"
                            print(self._humidity)
                        }
                    }
                    if let weather = list[self._dayId]["weather"] as? [Dictionary<String,AnyObject>] {
                        if let state = weather[0]["main"] {
                            self._weatherState = "\(state)"
                            print(self._weatherState)
                        }
                    }
                    
                    if let wind = list[self._dayId]["wind"] as? Dictionary<String,AnyObject> {
                        if let speed = wind["speed"] {
                            self._windSpeed = "\(speed)"
                            print(self._windSpeed)
                        }
                    }
                    
                    if let date = list[self._dayId]["dt_txt"] {
                        print(date)
                    }
                    completed()
                }
            }
            
        }
        
    }
}
