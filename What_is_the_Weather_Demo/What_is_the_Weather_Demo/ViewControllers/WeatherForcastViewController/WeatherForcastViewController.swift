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
    
    var expandedCell: ForcastCollectionViewCell? = nil
    
    var collapsedWidth: CGFloat! = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("didLoad")
        self.collectionView.register(UINib(nibName: "ForcastCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ForcastCollectionViewCell")
        collapsedWidth = ((self.collectionView.frame.width / 5) > 100) ? 100:self.collectionView.frame.width / 5
    }
}

extension WeatherForcastViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let expandedCell = expandedCell, let isExpanded = expandedCell.weatherView.isExpanded, isExpanded else {
            return CGSize(width: collapsedWidth, height: self.collectionView.frame.height)
        }
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
    }
}

extension WeatherForcastViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForcastCollectionViewCell", for: indexPath) as? ForcastCollectionViewCell else {return UICollectionViewCell()}
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ForcastCollectionViewCell else {return}
        cell.weatherView.isExpanded = true
        self.expandedCell = cell
        collectionView.reloadItems(at: [indexPath])
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ForcastCollectionViewCell else {return}
        cell.weatherView.isExpanded = false
        collectionView.reloadItems(at: [indexPath])
    }
}
