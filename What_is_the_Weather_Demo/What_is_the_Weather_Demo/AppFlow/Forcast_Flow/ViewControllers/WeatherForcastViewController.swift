//
//  WeatherForcastViewController.swift
//  What_is_the_Weather_Demo
//
//  Created by Tyler Wells on 3/21/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import UIKit
class WeatherForcastViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataArray = [ForecastDay]() {
        didSet {
            if dataArray.count > 0 {
                self.collectionView.reloadData()
            }
        }
    }
    
    var expandedCellIndexes = [Int]()
    
    var collapsedWidth: CGFloat! = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(nibName: "ForecastCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ForecastCollectionViewCell")
        self.collectionView.allowsSelection = false
        collapsedWidth = ((self.collectionView.frame.width / 5) > 100) ? 100:self.collectionView.frame.width / 5
        
        APIHandler.get16DayForcast(zipCode: "29640", success: {[weak self] forecast,_ in
            self?.dataArray = forecast.forecastDays
            }, failure: {print($0?.description as Any)})
    }
}

extension WeatherForcastViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.expandedCellIndexes.contains(indexPath.row) {
            print("setting expanded")
            return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
        }
        return CGSize(width: collapsedWidth, height: self.collectionView.frame.height)
    }
}

extension WeatherForcastViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (self.dataArray.count > 0) ? 1:0
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForecastCollectionViewCell", for: indexPath) as? ForecastCollectionViewCell else {return UICollectionViewCell()}
        
        if cell.viewModel == nil {
            let forcastDay = self.dataArray[indexPath.row]
            cell.viewModel = ForecastCollectionViewCellViewModel(data: forcastDay, index: indexPath)
        }
        if cell.viewModel?.cellDelegate == nil {
            cell.viewModel?.cellDelegate = self
        }
        if self.expandedCellIndexes.contains(indexPath.row) {
            cell.viewModel?.isExpanded = true
        }
        else {
            cell.viewModel?.isExpanded = false
        }
        return cell
    }
}

extension WeatherForcastViewController: ForestCollectionViewCellDelegate {
    func didPressCollapseButton(at indexPath: IndexPath) {
        print("did press collapse")
        self.expandedCellIndexes.removeAll(where: {$0 == indexPath.row})
        print(self.expandedCellIndexes)
        self.collectionView.reloadItems(at: [indexPath])
    }
    
    func didPressExpandButton(at indexPath: IndexPath) {
        print("did press expand")
        self.expandedCellIndexes.append(indexPath.row)
        print(self.expandedCellIndexes)
        collectionView.reloadItems(at: [indexPath])
    }
}
