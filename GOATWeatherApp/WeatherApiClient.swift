//
//  WeatherApiClient.swift
//  GOATWeatherApp
//
//  Created by Duncan Riefler on 1/19/20.
//  Copyright © 2020 Duncan Riefler. All rights reserved.
//

import Foundation
import Alamofire

class WeatherApiClient {
    private let key = "caf1edcf83561fbf16ef486924e94bc0"
    private let losAngelesCoordinates = (34.0522, 118.2437)
    
    func getLosAngelesForecast() {
        Alamofire.request(URL(string: "https://api.darksky.net/forecast/\(key)/\(losAngelesCoordinates.0),\(losAngelesCoordinates.1)")!)
            .validate()
            .response { (response) in
                if let data = response.data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        print(json)
                    }
                    catch {
                        
                    }
                }
        }
    }
}
