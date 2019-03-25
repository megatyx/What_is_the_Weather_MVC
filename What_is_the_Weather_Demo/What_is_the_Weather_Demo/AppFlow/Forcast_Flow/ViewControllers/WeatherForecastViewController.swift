//
//  WeatherForcastViewController.swift
//  What_is_the_Weather_Demo
//
//  Created by Tyler Wells on 3/21/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import UIKit
class WeatherForecastViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            if tableView != nil {
                self.registerTableViewCells()
            }
        }
    }

    
    var dataArray = [ForecastDay]()
    
    var expandedCellIndexes = [Int]()
    
    var collapsedWidth: CGFloat! = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIHandler.get16DayForcast(cityID: "420037612", success: {[weak self] forecast,_ in
            self?.dataArray = forecast.forecastDays
            }, failure: {print($0?.description as Any)})
    }

    fileprivate func registerTableViewCells() {
        self.tableView.register(WeatherInformationTableViewCell.self, forCellReuseIdentifier: WeatherInformationTableViewCell.reuseIdentifier)
    }
}

extension WeatherForecastViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherInformationTableViewCell.reuseIdentifier, for: indexPath) as? WeatherInformationTableViewCell else {return UITableViewCell()}
        let forcastDay =  self.dataArray[indexPath.row]
        cell.weatherInformationView.viewModel = WeatherInformationViewModel(weatherInformation: forcastDay.weather[0])
        return cell
    }


}
