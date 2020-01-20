//
//  WeatherApiClient.swift
//  GOATWeatherApp
//
//  Created by Duncan Riefler on 1/19/20.
//  Copyright © 2020 Duncan Riefler. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeatherApiClient {
    private static let key = "caf1edcf83561fbf16ef486924e94bc0"
    private static let losAngelesCoordinates = (34.0522, 118.2437)
    private static let londonCoordinates = (51.5074, 0.1278)
    var coordinates = WeatherApiClient.londonCoordinates
    
    func getLosAngelesForecast(completion: @escaping ([DailyWeatherModel] , NSError?) -> Void) {
        var forecast: [DailyWeatherModel] = []
        Alamofire.request(URL(string: "https://api.darksky.net/forecast/\(WeatherApiClient.key)/\(coordinates.0),\(coordinates.1)")!)
            .validate()
            .response { (response) in
                if let data = response.data {
                    do {
                        let json = try JSON(data: data)
                        let forecastJSON = json["daily"]["data"]
                        for entry in forecastJSON {
                            let model = DailyWeatherModel(json: entry.1)
                            print(entry)
                            forecast.append(model)
                        }
                        completion(forecast, nil)
                    }
                    catch {
                        completion(forecast, NSError())
                    }
                }
        }
    }
}
