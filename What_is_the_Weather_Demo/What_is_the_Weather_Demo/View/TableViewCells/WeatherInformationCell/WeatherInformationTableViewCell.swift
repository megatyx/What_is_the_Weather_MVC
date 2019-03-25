//
//  WeatherInformationTableViewCell.swift
//  What_is_the_Weather_Demo
//
//  Created by Tyler Wells on 3/25/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import UIKit

class WeatherInformationTableViewCell: UITableViewCell {

    static let reuseIdentifier = "WeatherInformationTableViewCell"
    
    
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var weatherIconContainerView: UIView!
    @IBOutlet weak var weatherIconImageView: UIImageView!
}
