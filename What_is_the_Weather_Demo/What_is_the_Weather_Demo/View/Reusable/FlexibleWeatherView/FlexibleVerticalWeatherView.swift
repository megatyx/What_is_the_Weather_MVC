//
//  FlexibleVerticalWeatherView.swift
//  What_is_the_Weather_Demo
//
//  Created by Tyler Wells on 3/21/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import UIKit

class FlexibleVerticalWeatherView: UIView {

    @IBOutlet weak var degreesLabel: UILabel!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            print("tableview set")
        }
    }
    @IBOutlet weak var weatherIconContainerView: UIView! {
        didSet {
             self.weatherIconContainerView.layer.cornerRadius = self.weatherIconContainerView.frame.size.width/2
            self.weatherIconContainerView.clipsToBounds = true
        }
    }
    @IBOutlet weak var weatherIconContainerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var weatherIconContainerViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var weatherIconImageView: UIImageView!



    var weatherData: Forecast?

    var isExpanded: Bool? {
        didSet {
            guard let isExpanded = isExpanded else {return}
            if isExpanded {
                self.expandView()
            } else {
                self.collapseView()
            }
        }
    }

    var shouldAnimateExpands: Bool = true
    var shouldAnimateCollapses: Bool = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //self.tableView.register(UINib(nibName: "Title_DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "Title_DetailTableViewCell")
        //self.collapseView()
    }
    
    private func expandView() {
        func inLineExpand() {
            self.tableView.isHidden = false
            self.weatherIconContainerViewBottomConstraint.constant = 16
        }
        if shouldAnimateExpands {
            UIView.animate(withDuration: 0.1, animations: {
                inLineExpand()
            })
        } else {
            inLineExpand()
        }
    }

    private func collapseView() {
        func inLineCollapse() {
            self.tableView.isHidden = true
            self.weatherIconContainerViewBottomConstraint.constant = self.frame.height / 2
        }
        if shouldAnimateExpands {
            UIView.animate(withDuration: 0.1, animations: {
                inLineCollapse()
            })
        } else {
            inLineCollapse()
        }
    }

}

extension FlexibleVerticalWeatherView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
