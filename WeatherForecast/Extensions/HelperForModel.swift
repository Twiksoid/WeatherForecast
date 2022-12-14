//
//  HelperForModel.swift
//  WeatherForecast
//
//  Created by Nikita Byzov on 13.12.2022.
//

import UIKit

struct HeaderData {
    var minMaxWeather: String
    var currentWeatherValue: String
    var descriptionWeather: String
    var timeRise: String
    var timeSunset: String
    var generalWeatherInfo: String
    var imageVisible: UIImage
    var valueVisible: String
    var imageRain: UIImage
    var valueRain: String
    var imageWind: UIImage
    var valueWind: String
}

struct MiniData {
    var cityID: Int32
    var textTimeWeather: String
    var imageCollectionView: UIImage
    var textWeather: String
}

struct TextData {
    var cityID: Int32
    var dataWeather: String
    var imageWeather: UIImage
    var vetPercent: String
    var descriptionWeather: String
    var degreesseData: String
}

struct DataForDay {
    var cityID: Int32
    var dataWeather: String
    var textTimeWeather: String
    var currentWeatherValue: String
    var imageGeneral: UIImage
    var descriptionWeather: String
    var imageWind: UIImage
    var valueWind: String
    var imageRain: UIImage
    var valueRain: String
    var imageVisible: UIImage
    var valueVisible: String
}

struct AllWeatherData {
    var cityID: Int32
    var cityName: String
    var minMaxWeather: String
    var currentWeatherValue: String
    var descriptionWeather: String
    var timeRise: String
    var timeSunset: String
    var generalWeatherInfo: String
    var imageVisible: UIImage
    var valueVisible: String
    var imageRain: UIImage
    var valueRain: String
    var imageWind: UIImage
    var valueWind: String
    
    var textTimeWeather: String
    var imageCollectionView: UIImage
    var textWeather: String
    
    var dataWeather: String
    var imageWeather: UIImage
    var vetPercent: String
    var extraTextWeather: String
    var degreesseData: String
}
