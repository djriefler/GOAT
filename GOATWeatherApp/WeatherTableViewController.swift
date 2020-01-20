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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherApiClient.getLosAngelesForecast()
    }


}

// MARK - UITableViewDataSource
extension WeatherTableViewController {
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
//    }
}
