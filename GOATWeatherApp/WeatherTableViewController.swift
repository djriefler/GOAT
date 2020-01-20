//
//  ViewController.swift
//  GOATWeatherApp
//
//  Created by Duncan Riefler on 1/19/20.
//  Copyright © 2020 Duncan Riefler. All rights reserved.
//

import UIKit

class WeatherTableViewController: UITableViewController {

    let weatherApiClient = WeatherApiClient()
    var weatherForecast: [DailyWeatherModel] = []
    private let reuseIdentifier = "WeatherCell"
    private let dateFormatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        weatherApiClient.getLosAngelesForecast() { (forecast, err) in
            DispatchQueue.main.async(execute: { [weak self] in
                self?.weatherForecast = forecast
                self?.setFormattedDates()
                self?.tableView.reloadData()
            })
        }
        
        dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        dateFormatter.timeZone = .current
    }

    func setFormattedDates() {
        for day in weatherForecast {
            let weekdayInt = Calendar.current.component(.weekday, from: day.date) - 1
            day.weekday = dateFormatter.weekdaySymbols[weekdayInt]
        }
    }
}

// MARK - UITableViewDelegate
extension WeatherTableViewController {
    
}

// MARK - UITableViewDataSource
extension WeatherTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherForecast.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? WeatherTableViewCell else { return UITableViewCell() }
        
        let dailyForecast = weatherForecast[indexPath.row]
        
        cell.iconImageView.image = UIImage(named: dailyForecast.weatherType.rawValue)
        cell.dateLabel.text = dailyForecast.weekday
        cell.lowTempLabel.text = String(dailyForecast.tempatureLow)
        cell.highTempLabel.text = String(dailyForecast.tempatureHigh)
        cell.backgroundColor = .white
        
        return cell

    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86
    }
}
