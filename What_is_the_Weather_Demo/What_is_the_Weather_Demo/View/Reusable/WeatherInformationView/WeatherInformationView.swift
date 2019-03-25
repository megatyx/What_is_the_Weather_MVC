//
//  WeatherInformationView.swift
//  What_is_the_Weather_Demo
//
//  Created by Tyler Wells on 3/24/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import UIKit

class WeatherInformationView: UIView {
    
    var viewModel: WeatherInformationViewModel? = nil {
        didSet {
            guard let viewModel = viewModel else {return}
            self.descriptionLabel.text = viewModel.weatherDescription
            self.weatherIconImageView.image = viewModel.weatherIcon
        }
    }

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var weatherIconContainerView: UIView! {
        didSet {
            self.weatherIconContainerView.layer.cornerRadius = self.weatherIconContainerView.frame.size.width/2
            self.weatherIconContainerView.clipsToBounds = true
        }
    }
    @IBOutlet weak var weatherIconImageView: UIImageView!
}
