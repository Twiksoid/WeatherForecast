//
//  WeatherDataController.swift
//  WeatherForecast
//
//  Created by Nikita Byzov on 13.12.2022.
//

import UIKit
import CoreLocation

class WeatherDataController: UIViewController {
    
    weak var pageMainSceneDelegate: PageViewController?
    
    func reloadData(){
        collectionView.reloadData()
        self.imagePlusButton.isHidden = true
    }
    
    var allWeatherData: AllWeatherData?
    var mini: [MiniData]?
    var text: [TextData]?
    var addressOfCity: String?
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?
    var isInit: Bool?
    
    private lazy var imagePlusButton: UIButton = {
        let image = UIButton()
        image.setImage(UIImage(named: "imagePlus.png"), for: .normal)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.addTarget(self, action: #selector(imageTapped), for: .touchUpInside)
        return image
    }()
    
    @objc private func imageTapped(){
        getDataForCurrentLocation()
    }
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 25
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout )
        collection.dataSource = self
        collection.delegate = self
        collection.layer.cornerRadius = 20
        collection.clipsToBounds = true
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Default")
        collection.register(HeaderCollectionViewCell.self, forCellWithReuseIdentifier: NamesOfCells.headerCell)
        collection.register(MiniWeatherCollectionViewCell.self, forCellWithReuseIdentifier: NamesOfCells.miniWeather)
        collection.register(TextWeatherDataCollectionViewCell.self, forCellWithReuseIdentifier: NamesOfCells.textCell)
        collection.register(ExplanationForDayView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NamesOfCells.explForDayView)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    init(allweatherData: AllWeatherData? = nil,
         addressOfCity: String? = nil,
         latitude: CLLocationDegrees? = nil,
         longitude: CLLocationDegrees? = nil,
         isInit: Bool? = nil,
         weatherMini: [MiniData]? = nil,
         textWeather: [TextData]? = nil
    ){
        super.init(nibName: nil, bundle: nil)
        self.addressOfCity = addressOfCity
        self.latitude = latitude
        self.longitude = longitude
        self.allWeatherData = allweatherData
        self.mini = weatherMini
        self.text = textWeather
        self.isInit = isInit
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if CoreDataManager.shared.city.count == 0 && isInit == true {
            collectionView.isHidden = true
            view.addSubview(imagePlusButton)
            
            NSLayoutConstraint.activate([
                imagePlusButton.heightAnchor.constraint(equalToConstant: 400),
                imagePlusButton.widthAnchor.constraint(equalToConstant: 400),
                imagePlusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                imagePlusButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)])
        } else {
            // тут циклится тогда
            //  getDataForCurrentLocation()
        }
        
        setupView()
    }
    
    private func getDataForCurrentLocation(){
        LocationManager.shared.getUserLocation { location in
            
            self.latitude = location.coordinate.latitude
            self.longitude = location.coordinate.longitude
            
            self.getDataLocationFor(lat: self.latitude!, lot: self.longitude!)
        }
    }
    
    private func setupView(){
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func getDataLocationFor(lat: CLLocationDegrees, lot: CLLocationDegrees){
        
        let tempValueFromSettings = CoreDataManager.shared.settings[0].temp
        var tempValueString: String = ""
        if tempValueFromSettings == 0 { tempValueString = APIData.metric } else { tempValueString = APIData.imperial}
        
        let urlForCertainTown = APIData.urlHTTPS+"lat=\(self.latitude!)"+"&lon=\(self.longitude!)"+"&cnt=\(APIData.cnt)"+"&appid=\(APIData.apiKey)"+"&units=\(tempValueString)"+"&lang=\(APIData.lang)"
        
        NetworkManager().downloadData(urlString: urlForCertainTown) { answer in
            if answer != nil {
                CoreDataManager.shared.saveNewWeatherDatas(weatherData: answer!)
                
                DispatchQueue.main.async {
                    self.imagePlusButton.isHidden = true
                    NotificationCenter.default.post(name: Notification.Name(rawValue: notificationKeyForCurrentTown), object: self)
                    //self.collectionView.reloadData()
                    self.collectionView.isHidden = false
                }
                
            } else {
                print("нил вернулся вместо ответа")
            }
        }
    }
}

extension WeatherDataController:  UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: NamesOfCells.explForDayView, for: indexPath) as! ExplanationForDayView
            sectionHeader.delegate = self
            sectionHeader.dataForExtension = text
            sectionHeader.setupCollectionHeader(forIndex: indexPath.section, and: allWeatherData?.cityName ?? Constants.townWithoutName)
            return sectionHeader
        } else { // без футера
            return UICollectionReusableView()
        }}
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 22)
    }
    
    // секция 1, шапка
    // секция 2, мини прогноз
    // секция 3, деталка
    // средние значения: для айфона 5 вместится, для айпада 11
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {return 1} else if section == 1 {
            // поскольку хотим поместить ячейки в ряд, а не листом, то нужно извратиться
            // высчитываем средний размер ячейки
            // относим его к размеру устройства
            // получаем количество ячеек, которые можем одновременно отразить (делать скролл не вижу смысла)
            let valueForDisplay = Int((collectionView.frame.width - 60 ) / 80)
            let valueFromMini = mini?.count ?? 0
            if valueFromMini >= valueForDisplay {return valueForDisplay} else if valueFromMini <= valueForDisplay { return valueFromMini} else { return 0}
        }  else {
            return text?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NamesOfCells.headerCell, for: indexPath) as? HeaderCollectionViewCell {
                cell.setupCell(for: allWeatherData ?? allWeatherData1)
                return cell
            } else { let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Default", for: indexPath)
                return cell}
        } else if indexPath.section == 1 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NamesOfCells.miniWeather, for: indexPath) as? MiniWeatherCollectionViewCell {
                cell.setupCell(for: mini?[indexPath.row] ?? miniDataExample)
                return cell
            } else { let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Default", for: indexPath)
                return cell }} else {
                    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NamesOfCells.textCell, for: indexPath) as? TextWeatherDataCollectionViewCell {
                        cell.backgroundColor = .specialLightBlue
                        cell.layer.cornerRadius = 10
                        cell.setupCell(for: text?[indexPath.row] ?? textDataExample)
                        return cell
                    } else { let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Default", for: indexPath)
                        return cell}
                }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.frame.width, height: 250)
        } else if indexPath.section == 1 {
            return CGSize(width: 65, height: 70)
        } else {
            return CGSize(width: collectionView.frame.width-10, height: 80)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
            
            let viewNameToGo = CertainDayWeatherDataController()
            viewNameToGo.delegateWeatherDataController = self
            viewNameToGo.cityID = mini?[indexPath.row].cityID
            
            navigationController?.pushViewController(viewNameToGo, animated: true)
        }
        
        if indexPath.section == 2 {
            
            let viewNameToGo = ExtendedWeatherDataController()
            viewNameToGo.delegateWeatherDataController = self
            viewNameToGo.country = allWeatherData?.country
            viewNameToGo.cityID = text?[indexPath.row].cityID
            viewNameToGo.dayForCity = text?[indexPath.row].dataWeather
            
            navigationController?.pushViewController(viewNameToGo, animated: true)
        }
    }
}
