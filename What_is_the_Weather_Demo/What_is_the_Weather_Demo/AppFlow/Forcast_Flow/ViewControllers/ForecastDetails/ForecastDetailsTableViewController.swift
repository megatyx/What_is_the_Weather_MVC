//
//  ForecastDetailsTableViewController.swift
//  What_is_the_Weather_Demo
//
//  Created by Tyler Wells on 3/24/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import UIKit

class ForecastDetailsTableViewController: UITableViewController {
    
    var viewModel: ForecastDetailsVCViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.allowsSelection = false
        self.tableView.register(UINib(nibName: WeatherInformationTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: WeatherInformationTableViewCell.reuseIdentifier)
        self.tableView.register(UINib(nibName: Title_DetailTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: Title_DetailTableViewCell.reuseIdentifier)
        self.tableView.register(UINib(nibName: CenteredLabelTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: CenteredLabelTableViewCell.reuseIdentifier)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowsToDisplay
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case viewModel.weatherRow:
            return 200
        default:
            return 100
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case viewModel.weatherRow:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherInformationTableViewCell.reuseIdentifier, for: indexPath) as? WeatherInformationTableViewCell else {return UITableViewCell()}
            let weatherInformation =  self.viewModel.data.weather[0]
            cell.currentTempLabel.isHidden = true
            cell.timeLabel.isHidden = true
            cell.descriptionLabel.text = weatherInformation.weatherStatusDetail
            cell.weatherIconImageView.image = weatherInformation.weatherStatus?.image
            return cell
        case viewModel.temperatureRow:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CenteredLabelTableViewCell.reuseIdentifier, for: indexPath) as? CenteredLabelTableViewCell else {return UITableViewCell()}
            let lows = lround(self.viewModel.data.temperatureDetails.temperature.min_Celsius)
            let highs = lround(self.viewModel.data.temperatureDetails.temperature.max_Celsius)
            cell.cellLabel.text = "\(lows)° - \(highs)°"
            return cell
        case viewModel.windSpeedRow:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Title_DetailTableViewCell.reuseIdentifier, for: indexPath) as? Title_DetailTableViewCell else {return UITableViewCell()}
            cell.leftLabel.text = "Wind Speed"
            cell.rightLabel.text = "\(viewModel.data.wind.speed)"
            return cell
        case viewModel.humidityRow:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Title_DetailTableViewCell.reuseIdentifier, for: indexPath) as? Title_DetailTableViewCell else {return UITableViewCell()}
            cell.leftLabel.text = "Humidity"
            cell.rightLabel.text = "\(viewModel.data.temperatureDetails.barometrics.humidity)%"
            return cell
        case viewModel.pressureRow:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Title_DetailTableViewCell.reuseIdentifier, for: indexPath) as? Title_DetailTableViewCell else {return UITableViewCell()}
            cell.leftLabel.text = "Pressure"
            cell.rightLabel.text = "\(viewModel.data.temperatureDetails.barometrics.pressure)"
            return cell
        default:
            return UITableViewCell()
        }
    }
}
