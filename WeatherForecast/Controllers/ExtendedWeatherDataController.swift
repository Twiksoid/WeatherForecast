//
//  ExtendedWeatherDataController.swift
//  WeatherForecast
//
//  Created by Nikita Byzov on 13.12.2022.
//

import UIKit

class ExtendedWeatherDataController: UIViewController {
    
    var delegateWeatherDataController: WeatherDataController?
    var cityID: Int32?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView(){
        view.backgroundColor = .white
    }
    
}
