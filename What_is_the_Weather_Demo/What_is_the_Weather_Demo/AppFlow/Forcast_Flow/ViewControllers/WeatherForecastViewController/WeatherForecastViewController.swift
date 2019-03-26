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
            self.tableView.register(UINib(nibName: WeatherInformationTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: WeatherInformationTableViewCell.reuseIdentifier)
        }
    }

    var viewModel: WeatherForecastVCViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getForecastData(success: {[weak self] in
            self?.viewModel.dataArray = $0
            }, failure: {_ in })
    }
}

extension WeatherForecastViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.viewModel.dataArray[section].sectionName
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.dataArray[section].sectionData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherInformationTableViewCell.reuseIdentifier, for: indexPath) as? WeatherInformationTableViewCell else {return UITableViewCell()}
        cell.viewModel =  self.viewModel.dataArray[indexPath.section].sectionData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let weatherVM = viewModel.dataArray[indexPath.section].sectionData[indexPath.row]
        guard let forecastData = self.viewModel.lookupDataByViewModel(weatherVM: weatherVM) else {return}
        let storyboard = UIStoryboard(name: "ForecastFlow", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "ForecastDetailsTableViewController") as? ForecastDetailsTableViewController else {return}
        controller.viewModel = ForecastDetailsVCViewModel(data: forecastData)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
