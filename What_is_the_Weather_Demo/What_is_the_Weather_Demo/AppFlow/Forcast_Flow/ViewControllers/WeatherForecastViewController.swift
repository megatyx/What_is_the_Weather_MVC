//
//  WeatherForcastViewController.swift
//  What_is_the_Weather_Demo
//
//  Created by Tyler Wells on 3/21/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import UIKit
class WeatherForecastViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    struct ForecastDisplayInformation {
        var sectionName: String
        var sectionData: [Forecast]
    }
    var dataArray = [ForecastDisplayInformation]()
    
    let dateFormatter = DateFormatter()
    let timeFormatter = DateFormatter()
    
    var expandedCellIndexes = [Int]()
    
    var collapsedWidth: CGFloat! = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerTableViewCells()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        timeFormatter.dateFormat = "HH:mm"
        APIHandler.get5DayForcast(city: City(id: 420037612), success: {[weak self] _, forecastArray,_ in
            var newData = [ForecastDisplayInformation]()
            for forecast in forecastArray {
                guard let potentialSectionName = self?.dateFormatter.string(from: forecast.time) else {return}
                if let sectionIndex = newData.firstIndex(where: {$0.sectionName == potentialSectionName}) {
                    newData[sectionIndex].sectionData.append(forecast)
                } else {
                    newData.append(ForecastDisplayInformation(sectionName: potentialSectionName, sectionData: [forecast]))
                }
            }
            
            newData.sort(by: {$0.sectionData[0].time.compare($1.sectionData[0].time) == .orderedAscending})
            
            self?.dataArray = newData
            self?.tableView.reloadData()
            }, failure: {print($0?.description as Any)})
    }

    fileprivate func registerTableViewCells() {
        self.tableView.register(UINib(nibName: WeatherInformationTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: WeatherInformationTableViewCell.reuseIdentifier)
    }
}

extension WeatherForecastViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.dataArray[section].sectionName
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray[section].sectionData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherInformationTableViewCell.reuseIdentifier, for: indexPath) as? WeatherInformationTableViewCell else {return UITableViewCell()}
        let sectionData =  self.dataArray[indexPath.section].sectionData[indexPath.row]
        let weatherInformation = sectionData.weather[0]
        cell.currentTempLabel.text = "\(lround(sectionData.temperatureDetails.temperature.current_Celsius))°"
        cell.timeLabel.text = self.timeFormatter.string(from: sectionData.time)
        cell.descriptionLabel.text = weatherInformation.weatherStatusDetail
        cell.weatherIconImageView.image = weatherInformation.weatherStatus?.image
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let forecastData = self.dataArray[indexPath.section].sectionData[indexPath.row]
        let storyboard = UIStoryboard(name: "ForecastFlow", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "ForecastDetailsTableViewController") as? ForecastDetailsTableViewController else {print("is nil");return}
        controller.viewModel = ForecastDetailsVCViewModel(data: forecastData)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
