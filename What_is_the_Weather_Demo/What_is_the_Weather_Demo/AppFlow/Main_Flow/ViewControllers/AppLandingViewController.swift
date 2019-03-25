//
//  AppLandingViewController.swift
//  What_is_the_Weather_Demo
//
//  Created by Tyler Wells on 3/22/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import UIKit

class AppLandingViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let storyboard = UIStoryboard(name: "ForecastFlow", bundle: nil)
        guard let controller = storyboard.instantiateInitialViewController() else {return}
        self.present(controller, animated: false, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
