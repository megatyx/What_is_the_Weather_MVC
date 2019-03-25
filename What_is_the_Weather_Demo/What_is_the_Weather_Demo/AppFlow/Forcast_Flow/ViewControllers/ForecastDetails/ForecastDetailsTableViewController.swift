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
        self.tableView.register(WeatherInformationTableViewCell.self, forCellReuseIdentifier: WeatherInformationTableViewCell.reuseIdentifier)
        self.tableView.register(Title_DetailTableViewCell.self, forCellReuseIdentifier: Title_DetailTableViewCell.reuseIdentifier)
        self.tableView.register(CenteredLabelTableViewCell.self, forCellReuseIdentifier: CenteredLabelTableViewCell.reuseIdentifier)
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
            return 100
        default:
            return 50
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case viewModel.weatherRow:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherInformationTableViewCell.reuseIdentifier, for: indexPath) as? WeatherInformationTableViewCell else {return UITableViewCell()}
            cell.weatherInformationView.viewModel = WeatherInformationViewModel(weatherInformation: self.viewModel.data.weather[0])
            return cell
        case viewModel.temperatureRow:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CenteredLabelTableViewCell.reuseIdentifier, for: indexPath) as? CenteredLabelTableViewCell else {return UITableViewCell()}
            cell.cellLabel.text = "\(self.viewModel.data.temperatureDetails.temperature)°"
            return cell
        case viewModel.windSpeedRow:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Title_DetailTableViewCell.reuseIdentifier, for: indexPath) as? Title_DetailTableViewCell else {return UITableViewCell()}
            cell.titleLabel.text = "Wind Speed"
            cell.detailLabel.text = "\(viewModel.data.wind.speed)"
            return cell
        case viewModel.humidityRow:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Title_DetailTableViewCell.reuseIdentifier, for: indexPath) as? Title_DetailTableViewCell else {return UITableViewCell()}
            cell.titleLabel.text = "Humidity"
            cell.detailLabel.text = "\(viewModel.data.temperatureDetails.barometrics.humidity)%"
            return cell
        case viewModel.pressureRow:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Title_DetailTableViewCell.reuseIdentifier, for: indexPath) as? Title_DetailTableViewCell else {return UITableViewCell()}
            cell.titleLabel.text = "Pressure"
            cell.detailLabel.text = "\(viewModel.data.temperatureDetails.barometrics.pressure)"
            return cell
        default:
            return UITableViewCell()
        }
    }
}
