//
//  DailyWeatherModel.swift
//  GOATWeatherApp
//
//  Created by Duncan Riefler on 1/19/20.
//  Copyright © 2020 Duncan Riefler. All rights reserved.
//

import Foundation
import SwiftyJSON

enum WeatherType: String {
    case Cloudy = "cloudy"
    case ClearDay = "clear-day"
    case ClearNight = "clear-night"
    case Fog = "fog"
    case PartlyCloudyDay = "partly-cloudy-day"
    case PartlyCloudyNight = "partly-cloudy-night"
    case Rain = "rain"
    case Sleet = "sleet"
    case Snow = "snow"
    case Wind = "wind"
}

class DailyWeatherModel {
    var tempatureHigh: Double = 0.0
    var tempatureLow: Double = 0.0
    var date = Date()
    var weekday: String = ""
    var weatherType: WeatherType
    var summary: String = ""

    init(json: JSON) {
        self.tempatureHigh = json["temperatureHigh"].doubleValue
        self.tempatureLow = json["temperatureLow"].doubleValue
        self.date = Date(timeIntervalSince1970: json["time"].doubleValue)
        self.weatherType = WeatherType(rawValue: json["icon"].stringValue) ?? .ClearDay
        self.summary = json["summary"].stringValue ?? "" 
    }
}
