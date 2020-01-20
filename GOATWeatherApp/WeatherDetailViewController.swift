//
//  WeatherDetailViewController.swift
//  GOATWeatherApp
//
//  Created by Duncan Riefler on 1/20/20.
//  Copyright © 2020 Duncan Riefler. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    @IBOutlet weak var summaryLabel: UILabel!
    
    var dailyWeather: DailyWeatherModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        summaryLabel.text = dailyWeather?.summary ?? ""
    }
}
