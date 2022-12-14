//
//  UIPageViewController.swift
//  WeatherForecast
//
//  Created by Nikita Byzov on 13.12.2022.
//

import UIKit
import CoreData
import CoreLocation

class PageViewController: UIPageViewController {
    
    var addressOfCity: String?
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?
    
    var arrayOfWeatherData = [AllWeatherData]()
    var miniWeatherData = [MiniData]()
    var textWeatherData = [TextData]()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // нужно сходить в сеть
        // для каждого города в таблице
        // загрузить данные
        // положить данные в виде объекта в массив
        // вызвать пейжвьюконтроллер
        setVCForPage()
        setupView()
    }
    
    private func setVCForPage(){
        arrayOfWeatherData = CoreDataManager.shared.getDataForCities()
        setViewControllers([arrayOfWVC[0]], direction: .forward, animated: true)
    }
    
    private func setupView(){
        setupNavigationBar()
        view.backgroundColor = .white
        delegate = self
        dataSource = self
        
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .black
        if #available(iOS 16.0, *) {
            pageControl.direction = .natural
        } else {
            
        }
        pageControl.backgroundStyle = .prominent
    }
    
    lazy var arrayOfWVC: [WeatherDataController] = {
        var weatherVCs = [WeatherDataController]()
        if CoreDataManager.shared.city.count == 0 {
            weatherVCs.append(WeatherDataController(isInit: true))
        } else {
            var counts: [Int32: Int] = [:]
            
            var citiesIDArrayForCompair = [Int32]()
            
            var i = 0
            for vc in arrayOfWeatherData {
                if i >= CoreDataManager.shared.city.count { break
                } else {
                    // выводим 1 город = 1 вью
                    if citiesIDArrayForCompair.contains(where: { $0 == vc.cityID }) { continue } else {
                        i += 1
                        citiesIDArrayForCompair.append(vc.cityID)
                        
                        miniWeatherData = createMini(cityID: vc.cityID)
                        textWeatherData = createExtension(cityID: vc.cityID)
                        
                        weatherVCs.append(WeatherDataController(allweatherData: vc, weatherMini: miniWeatherData, textWeather: textWeatherData))
                    }
                }
            }}
        return weatherVCs
    }()
    
    private func createMini(cityID: Int32) -> [MiniData]{
        var miniDate = [MiniData]()
        
        for y in 0...arrayOfWeatherData.count-1 {
            if arrayOfWeatherData[y].cityID == cityID {
                let mini: MiniData = .init(
                    cityID: cityID,
                    textTimeWeather: arrayOfWeatherData[y].textTimeWeather,
                    imageCollectionView: arrayOfWeatherData[y].imageCollectionView,
                    textWeather: arrayOfWeatherData[y].textWeather)
                miniDate.append(mini)
            }
        }
        
        // сортируем данные по времени от меньшего к большему
        miniDate.sort { $0.textTimeWeather < $1.textTimeWeather }
        print("Данные для миниатюры погоды - ", miniDate)
        return miniDate
    }
    
    private func createExtension(cityID: Int32) -> [TextData] {
        var textDate = [TextData]()
        
        var datesForCompare = [String]()
        var i = 0
        
        for y in arrayOfWeatherData {
            if i >= arrayOfWeatherData.count { break } else {
                if y.cityID == cityID , !(datesForCompare.contains(where: {$0 == y.dataWeather} ))  {
                    i += 1
                    let text: TextData = .init(cityID: cityID,
                                               dataWeather: y.dataWeather,
                                               imageWeather: y.imageCollectionView,
                                               vetPercent: y.valueRain,
                                               descriptionWeather: y.descriptionWeather,
                                               degreesseData: y.degreesseData)
                    textDate.append(text)
                    datesForCompare.append(y.dataWeather)
                } else { i += 1}
            }
        }
        
        // сортируем данные по времени от меньшего к большему
        textDate.sort { $0.dataWeather < $1.dataWeather }
        return textDate
    }
    
    private func setupNavigationBar(){
        if arrayOfWeatherData.count == 0 {
            navigationItem.title = Constants.defaultTownName
        } else { navigationItem.title = arrayOfWeatherData[0].cityName}
        navigationController?.navigationBar.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = false
        
        // создаю новый объект в верхнем баре
        let settings = UIBarButtonItem(image: UIImage(systemName: "server.rack"),
                                       style: .plain,
                                       target: self,
                                       action: #selector(settingsTapped))
        let newTown = UIBarButtonItem(image: UIImage(systemName: "location.magnifyingglass"),
                                      style: .plain,
                                      target: self,
                                      action: #selector(newTownTapped))
        
        // добавляю его в доступные к выводу справа и слева
        navigationItem.rightBarButtonItems = [newTown]
        navigationItem.leftBarButtonItems = [settings]
    }
    
    @objc private func settingsTapped() {
        navigationController?.pushViewController(SettingsController(), animated: true)
    }
    @objc private func newTownTapped() {
        // тут нужно уже не локацию спрашивать, а алерт показывать
        // чтобы из этого алерта захватить город и передать его в модель
        TextPicker.defaultPicker.getText(in: self) { text in
            self.addressOfCity = text
            if self.addressOfCity != "" || self.addressOfCity != nil {
                LocationManager.shared.forwardGeocoding(address: self.addressOfCity!) { data in
                    self.latitude = data.latitude
                    self.longitude = data.longitude
                    
                    print(self.addressOfCity!)
                    print(self.latitude!)
                    print(self.longitude!)
                    
                    self.getDataLocationFor(lat: self.latitude!, lot: self.longitude!)
                } } else {
                    print("nil field")
                }
        }
    }
    
    private func getDataLocationFor(lat: CLLocationDegrees, lot: CLLocationDegrees){
        
        let tempValueFromSettings = CoreDataManager.shared.settings[0].temp
        var tempValueString: String = ""
        if tempValueFromSettings == 0 { tempValueString = APIData.metric } else { tempValueString = APIData.imperial}
        
        let urlForCertainTown = APIData.urlHTTPS+"lat=\(self.latitude!)"+"&lon=\(self.longitude!)"+"&cnt=\(APIData.cnt)"+"&appid=\(APIData.apiKey)"+"&units=\(tempValueString)"+"&lang=\(APIData.lang)"
        
        NetworkManager().downloadData(urlString: urlForCertainTown) { answer in
            if answer != nil {
                CoreDataManager.shared.saveNewWeatherDatas(weatherData: answer!)
            } else {
                print("нил вернулся вместо ответа")
            }
        }
    }
    
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        
            super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
        }
    
    //    required init?(coder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let vc  = viewController as? WeatherDataController {
            if let indexOfVC = arrayOfWVC.firstIndex(of: vc) {
                if indexOfVC > 0 {
                    vc.reloadData()
                    return arrayOfWVC[indexOfVC - 1] }
            }} else { return nil}
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let vc  = viewController as? WeatherDataController {
            if let indexOfVC = arrayOfWVC.firstIndex(of: vc) {
                if indexOfVC < arrayOfWVC.count - 1 {
                    vc.reloadData()
                    return arrayOfWVC[indexOfVC + 1]
                }
            }} else { return nil}
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        arrayOfWVC.count
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        0
    }
}
