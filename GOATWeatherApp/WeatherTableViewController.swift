//
//  ViewController.swift
//  GOATWeatherApp
//
//  Created by Duncan Riefler on 1/19/20.
//  Copyright © 2020 Duncan Riefler. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherTableViewController: UITableViewController {

    private let weatherApiClient = WeatherApiClient()
    private var weatherForecast: [DailyWeatherModel] = []
    private let reuseIdentifier = "WeatherCell"
    private let dateFormatter = DateFormatter()
    private var locationManager = CLLocationManager()
    private let cellHeight: CGFloat = 86

    override func viewDidLoad() {
        super.viewDidLoad()
        let navBarItem = UIBarButtonItem(image: UIImage(named: "clear-day"), style: .plain, target: self, action: #selector(askPermissions))
        self.navigationItem.rightBarButtonItem = navBarItem
        
        dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        dateFormatter.timeZone = .current
        
        locationManager.delegate = self
        if CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func loadWeather() {
        weatherApiClient.getLosAngelesForecast() { (result) in
            DispatchQueue.main.async(execute: { [weak self] in
                switch result {
                case .success(let forecast):
                    self?.weatherForecast = forecast
                    self?.setFormattedDates()
                    self?.tableView.reloadData()
                case .failure(let err):
                    print(err)
                }
            })
        }
    }

    // Date formatting done here because DateFormatter object is expensive to create so we create it once in the view controller and format dates from here
    func setFormattedDates() {
        for day in weatherForecast {
            let weekdayInt = Calendar.current.component(.weekday, from: day.date) - 1
            day.weekday = dateFormatter.weekdaySymbols[weekdayInt]
        }
    }
    
    @objc func askPermissions() {
        locationManager.requestAlwaysAuthorization()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? WeatherDetailViewController, let index = tableView.indexPathForSelectedRow {
            vc.dailyWeather = weatherForecast[index.row]
        }
    }
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
        return cellHeight
    }
}

extension WeatherTableViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            weatherApiClient.coordinates = (location.coordinate.latitude, location.coordinate.longitude)
            loadWeather()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
