//
//  CoreDataManager.swift
//  WeatherForecast
//
//  Created by Nikita Byzov on 13.12.2022.
//

import UIKit
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    init(){
        reloadData()
    }
    
    var settings = [Settings]()
    var city = [CityTable]()
    var general = [GeneralTable]()
    
    func checkSettings(){
        let request = Settings.fetchRequest()
        let setting = (try? persistentContainer.viewContext.fetch(request)) ?? []
        self.settings = setting
    }
    
    func reloadData(){
        checkSettings()
        getFavoriteCities()
    }
    
    func getFavoriteCities(){
        let request = CityTable.fetchRequest()
        let cities = (try? persistentContainer.viewContext.fetch(request))
        self.city = cities ?? []
    }
    
    private func getCurrentData(for identificator: String) -> String {
        let currentDay = Date()
        let fortatter = DateFormatter()
        fortatter.timeStyle = .short
        fortatter.dateStyle = .full
        fortatter.timeZone = .current
        fortatter.locale = .autoupdatingCurrent
        // симулятор не цеплял, если принудительно не прописать
        // на реальном устройстве лучше отключить, наверное
        fortatter.locale = Locale(identifier: identificator)
        let currentDateTime = fortatter.string(from: currentDay)
        return currentDateTime
    }
    
    func catchData(for cityID: Int32, and country: String) -> [AllWeatherData] {
        
        var dataForCityInDay = [AllWeatherData]()
        let currentDateTime = getCurrentData(for: country)
        
        let requstGeneralTable = GeneralTable.fetchRequest()
        let predicateCityID = NSPredicate(format: "cityID = %@", String(cityID))
        requstGeneralTable.predicate = predicateCityID
        
        let requestCityTable = CityTable.fetchRequest()
        let predicateID = NSPredicate(format: "id = %@", String(cityID))
        requestCityTable.predicate = predicateID
        let cityData = (try? persistentContainer.viewContext.fetch(requestCityTable)) ?? []
        
        var generalWeatherData = (try? persistentContainer.viewContext.fetch(requstGeneralTable)) ?? []
        
        // сортируем даты от меньшего к большему
        generalWeatherData.sort { $0.dt < $1.dt }
        
        for i in generalWeatherData {
            
            let timeForPrediction = getTime(forValue: i.dt)
            let DateForPrediction = getData(forValue: i.dt)
            
            let data = AllWeatherData(
                cityID: i.cityID,
                cityName: i.cityName!,
                minMaxWeather: "\(String(Int(i.temp_min)))º / \(String(Int(i.temp_max)))º" ,
                feels_like: String(Int(i.feels_like)),
                currentWeatherValue: String(Int(i.temp)) + "º",
                descriptionWeather: String(i.descW ?? ""),
                timeRise: getTime(forValue: cityData[0].sunrise),
                timeSunset: getTime(forValue: cityData[0].sunset),
                generalWeatherInfo: currentDateTime,
                imageVisible: UIImage(systemName: "smoke")!,
                valueVisible: String(Int(i.pop)) + "%",
                imageRain: UIImage(systemName: "cloud.rain")!,
                valueRain: "0%",
                imageWind: UIImage(systemName: "wind")!,
                valueWind: String(Int(i.speed)) + "м/с",
                country: cityData[0].country ?? "ru",
                textTimeWeather: timeForPrediction,
                imageCollectionView: UIImage(named: String(i.icon!))!,
                textWeather: String(Int(i.temp)) + "º",
                dataWeather: DateForPrediction,
                imageWeather: UIImage(named: String(i.icon!))!,
                vetPercent: String(Int(i.humidity)) + "%",
                extraTextWeather: String(i.descW ?? ""),
                degreesseData: "\(String(Int(i.temp_min)))º- \(String(Int(i.temp_max)))º")
            
            dataForCityInDay.append(data)
        }
        return dataForCityInDay
    }
    
    func getDataForCertainTown(for cityID: Int32) -> [DataForDay] {
        var arrayOfData = [DataForDay]()
        //let currentDay = Date()
        let fortatter = DateFormatter()
        fortatter.timeStyle = .short
        fortatter.dateStyle = .full
        
        let requstGeneralTable = GeneralTable.fetchRequest()
        let predicateCityID = NSPredicate(format: "cityID = %@", String(cityID))
        //let currentTime = Int32(Date().timeIntervalSince1970)
        
        requstGeneralTable.predicate = predicateCityID
        
        var generalWeatherData = (try? persistentContainer.viewContext.fetch(requstGeneralTable)) ?? []
        
        // сортируем даты от меньшего к большему
        generalWeatherData.sort { $0.dt < $1.dt }
        
        for i in generalWeatherData {
            
            // пришлось вынести иначе компилятор не мог обработать
            
            let timeForPrediction = getTime(forValue: i.dt)
            let dateForPrediction = getData(forValue: i.dt)
            let currentWeatherValue = String(Int(i.temp))
            let imageGeneral = UIImage(named: i.icon ?? "04n")!
            let descriptionWeather = String(i.descW ?? "")
            let imageWind = UIImage(systemName: "wind")!
            let valueWind = String(Int(i.speed)) + "м/с"
            let imageRain = UIImage(systemName: "cloud.rain")!
            let imageVisible = UIImage(systemName: "cloud.fill")!
            let valueVisible = String(Int(i.pop)) + "%"
            
            let data: DataForDay = .init(cityID: i.cityID,
                                         dataWeather: dateForPrediction,
                                         textTimeWeather: timeForPrediction,
                                         currentWeatherValue: currentWeatherValue,
                                         imageGeneral: imageGeneral,
                                         descriptionWeather: descriptionWeather,
                                         imageWind: imageWind,
                                         valueWind: valueWind,
                                         imageRain: imageRain,
                                         valueRain: "0%" ,
                                         imageVisible: imageVisible,
                                         valueVisible: valueVisible )
            
            arrayOfData.append(data)
        }
        return arrayOfData
    }
    
    func getDataForCities() -> [AllWeatherData] {
        getFavoriteCities()
        
        var arrayOfWeatherData = [AllWeatherData]()

        if city.count > 0 {
            
            for i in 0...city.count-1 {
                let cityObject = city[i]
                
                let requstGeneralTable = GeneralTable.fetchRequest()
                let predicateCityID = NSPredicate(format: "cityID = %@", String(cityObject.id))
                let currentTime = Int32(Date().timeIntervalSince1970)
                let predicateCityTime = NSPredicate(format: "dt > %@", String(currentTime))
                let allPredicates = NSCompoundPredicate(type: .and, subpredicates: [predicateCityID, predicateCityTime])
                requstGeneralTable.predicate = allPredicates
                
                var generalWeatherData = (try? persistentContainer.viewContext.fetch(requstGeneralTable)) ?? []
                
                // сортируем даты от меньшего к большему
                generalWeatherData.sort { $0.dt < $1.dt }
                
                for i in generalWeatherData {
                    let currentDateTime = getCurrentData(for: cityObject.country ?? "ru")
                    let timeForPrediction = getTime(forValue: i.dt)
                    let DateForPrediction = getData(forValue: i.dt)
                    
                    let data = AllWeatherData(
                        cityID: i.cityID,
                        cityName: i.cityName!,
                        minMaxWeather: "\(String(Int(i.temp_min)))º / \(String(Int(i.temp_max)))º" ,
                        feels_like: String(Int(i.feels_like)),
                        currentWeatherValue: String(Int(i.temp)) + "º",
                        descriptionWeather: String(i.descW ?? ""),
                        timeRise: getTime(forValue: cityObject.sunrise),
                        timeSunset: getTime(forValue: cityObject.sunset),
                        generalWeatherInfo: currentDateTime,
                        imageVisible: UIImage(systemName: "smoke")!,
                        valueVisible: String(Int(i.pop)) + "%",
                        imageRain: UIImage(systemName: "cloud.rain")!,
                        valueRain: "0%",
                        imageWind: UIImage(systemName: "wind")!,
                        valueWind: String(Int(i.speed)) + "м/с",
                        country: cityObject.country ?? "ru",
                        textTimeWeather: timeForPrediction,
                        imageCollectionView: UIImage(named: String(i.icon!))!,
                        textWeather: String(Int(i.temp)) + "º",
                        dataWeather: DateForPrediction,
                        imageWeather: UIImage(named: String(i.icon!))!,
                        vetPercent: String(Int(i.humidity)) + "%",
                        extraTextWeather: String(i.descW ?? ""),
                        degreesseData: "\(String(Int(i.temp_min)))º- \(String(Int(i.temp_max)))º")
                    
                    arrayOfWeatherData.append(data)
                }}}
        return arrayOfWeatherData
    }
    
    private func getTime(forValue: Int32) -> String {
        let timeForPrediction = Date(timeIntervalSince1970: TimeInterval(forValue))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.dateStyle = DateFormatter.Style.none
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: timeForPrediction)
    }
    
    private func getData(forValue: Int32) -> String{
        let DateForPrediction = Date(timeIntervalSince1970: TimeInterval(forValue))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: DateForPrediction)
    }
    
    // проверим наличие данных в таблицах
    func checkData(){
        
        let requestForGeneral = GeneralTable.fetchRequest()
        let general = (try? persistentContainer.viewContext.fetch(requestForGeneral))
        self.general = general ?? []
        
        saveContext()
    }
    
    func createSettings(temp: Int16, speed: Int16, hours: Int16, notifications: Int16){
        persistentContainer.performBackgroundTask({ contexBackground in
            let initialSettings = Settings(context: contexBackground)
            initialSettings.temp = temp
            initialSettings.speed = speed
            initialSettings.hours = hours
            initialSettings.notification = notifications
            
            try? contexBackground.save()
            DispatchQueue.main.async {
                self.reloadData()
            }
        })
    }
    
    func setNewSettingsValue(deleteCurrentSettings: Settings, temp: Int16, speed: Int16, hours: Int16, notifications: Int16){
        deleteAllSettings(settings: deleteCurrentSettings)
        createSettings(temp: temp, speed: speed, hours: hours, notifications: notifications)
    }
    
    func deleteAllSettings(settings: Settings){
        persistentContainer.viewContext.delete(settings)
        saveContext()
        reloadData()
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WeatherForecast")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo), \(error.localizedDescription)")
            }
        })
        return container
    }()
    
    func saveNewWeatherDatas(weatherData: Answer){
        // пишут, что в weather может быть несколько условий погоды
        // но добиться такого примера не получилось пока
        // если воспроизведется, то нужна такая конструкция
        // а пока можно всегда 0 брать
        // вроде, упасть не должно критично
        //        for i in 0...weatherData.list.count {
        //            if weatherData.list[i].weather.count > 1 {
        //        } else {}
        
        DispatchQueue.main.async {
            
            // нужно сохранить отдельно данные по городу
            self.persistentContainer.performBackgroundTask { contexBackgroundWeather in
                let weatherDataForCity = CityTable(context: contexBackgroundWeather)
                
                if CoreDataManager.shared.city.contains(where: { $0.name == weatherData.city.name }) {
                    print("Такой город уже есть, не добавляем")
                } else {
                    weatherDataForCity.id = weatherData.city.id
                    weatherDataForCity.name = weatherData.city.name
                    weatherDataForCity.country = weatherData.city.country
                    weatherDataForCity.sunrise = weatherData.city.sunrise
                    weatherDataForCity.sunset = weatherData.city.sunset
                    weatherDataForCity.lat = weatherData.city.coord.lat
                    weatherDataForCity.lon = weatherData.city.coord.lon
                    
                    try? contexBackgroundWeather.save()
                    DispatchQueue.main.async {
                        //  self.reloadData()
                        self.checkData()
                    }
                }
            }
            
            for i in 0...weatherData.list.count-1 {
                
                self.persistentContainer.performBackgroundTask { contexBackgroundWeather in
                    let weatherDataForAll = GeneralTable(context: contexBackgroundWeather)
                    weatherDataForAll.cityName = weatherData.city.name
                    weatherDataForAll.cityID = weatherData.city.id
                    weatherDataForAll.dt = Int32(weatherData.list[i].dt)
                    weatherDataForAll.pop = weatherData.list[i].pop
                    weatherDataForAll.dt_text = weatherData.list[i].dt_txt
                    
                    weatherDataForAll.temp = weatherData.list[i].main.temp
                    weatherDataForAll.feels_like = weatherData.list[i].main.feels_like
                    weatherDataForAll.temp_min = weatherData.list[i].main.temp_min
                    weatherDataForAll.temp_max = weatherData.list[i].main.temp_max
                    weatherDataForAll.pressure = weatherData.list[i].main.pressure
                    weatherDataForAll.humidity = weatherData.list[i].main.humidity
                    
                    weatherDataForAll.main = weatherData.list[i].weather[0].main
                    weatherDataForAll.descW = weatherData.list[i].weather[0].description
                    weatherDataForAll.icon = weatherData.list[i].weather[0].icon
                    
                    weatherDataForAll.all = Int16(weatherData.list[i].clouds.all)
                    
                    weatherDataForAll.speed = weatherData.list[i].wind.speed
                    weatherDataForAll.deg = Int16(weatherData.list[i].wind.deg)
                    
                    try? contexBackgroundWeather.save()
                    DispatchQueue.main.async {
                        //self.reloadData()
                        self.checkData()
                    }
                }}}
        
        // слушатель должен обновить данные
        NotificationCenter.default.post(name: Notification.Name(rawValue: notificationKeyForNetUpdate), object: self)
    }
    
    func deleteAllData(general: [GeneralTable]){
        for i in 0...general.count-1 {
            persistentContainer.viewContext.delete(general[i])
            saveContext()
        }
    }
    
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                context.automaticallyMergesChangesFromParent = true
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
