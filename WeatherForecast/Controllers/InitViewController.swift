//
//  InitViewController.swift
//  WeatherForecast
//
//  Created by Nikita Byzov on 13.12.2022.
//

import UIKit
import CoreLocation

// ключ для нотификатора
let notificationKeyForNetUpdate = "getNetWeatherData"

class InitViewController: UINavigationController {
    
    private let text: UILabel = {
        let text = UILabel()
        text.textAlignment = .center
        text.font = .systemFont(ofSize: 18)
        text.text = Constants.textWhileLoadingInit
        text.numberOfLines = 0
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        if CoreDataManager.shared.city.count == 0 { makeRootController() } else {
            
            for i in CoreDataManager.shared.city {
                getDataLocationFor(lat: i.lat, lot: i.lon)
            }}}
    
    private func getDataLocationFor(lat: CLLocationDegrees, lot: CLLocationDegrees){
        let tempValueFromSettings = CoreDataManager.shared.settings[0].temp
        var tempValueString: String = ""
        if tempValueFromSettings == 0 { tempValueString = APIData.metric } else { tempValueString = APIData.imperial}
        
        let urlForCertainTown = APIData.urlHTTPS+"lat=\(lat)"+"&lon=\(lot)"+"&cnt=\(APIData.cnt)"+"&appid=\(APIData.apiKey)"+"&units=\(tempValueString)"+"&lang=\(APIData.lang)"
        
        NetworkManager().downloadData(urlString: urlForCertainTown) { answer in
            if answer != nil {
                CoreDataManager.shared.saveNewWeatherDatas(weatherData: answer!)
                DispatchQueue.main.async { [self] in
                    // слушатель, чтобы обновлять контроллер
                    NotificationCenter.default.addObserver(self, selector: #selector(makeRootController), name: Notification.Name(rawValue: notificationKeyForNetUpdate), object: nil)
                    self.makeRootController()
                }
            } else {
                print("нил вернулся вместо ответа")
            }
        }
    }
    
   private func setupView(){
        view.backgroundColor = .white
        view.addSubview(text)
        
        NSLayoutConstraint.activate([
        
            text.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            text.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
   @objc private func makeRootController(){
        var viewControllerForShowing: UIViewController
        viewControllerForShowing = PageViewController()
        
        if (UserDefaults.standard.value(forKey: "onboarding") as? String) == nil {
            self.text.isHidden = true
            viewControllerForShowing = PermissionLocationController()
            pushViewController(viewControllerForShowing, animated: true)
        } else {
            DispatchQueue.main.async {
                self.text.isHidden = true
                self.pushViewController(viewControllerForShowing, animated: true)
            }}
    }
}
