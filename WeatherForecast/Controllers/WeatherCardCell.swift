//
//  WeatherCardCell.swift
//  WeatherForecast
//
//  Created by Nikita Byzov on 15.12.2022.
//

import UIKit

class WeatherCardCell: UITableViewCell {
    
    private lazy var currentImage: UIImageView = {
        let image = UIImageView()
        image.tintColor = .specialBlue
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var tempValue: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.numberOfLines = 0
        text.textAlignment = .center
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var tempText: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.numberOfLines = 0
        text.textAlignment = .left
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var tempImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "thermometer.sun")
        image.tintColor = .specialBlue
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var tempDescription: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.text = "По ощущениям"
        text.numberOfLines = 0
        text.textAlignment = .left
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var tempDayValue: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.numberOfLines = 0
        text.textAlignment = .right
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var windImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "wind")
        image.tintColor = .specialBlue
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var windDescription: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.text = "Ветер"
        text.numberOfLines = 0
        text.textAlignment = .left
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var windDayValue: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.numberOfLines = 0
        text.textAlignment = .right
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var rainImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "cloud.heavyrain")
        image.tintColor = .specialBlue
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var rainDescription: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.text = "Дождь"
        text.numberOfLines = 0
        text.textAlignment = .left
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var rainDayValue: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.numberOfLines = 0
        text.textAlignment = .right
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var cloudsImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "cloud.fill")
        image.tintColor = .specialBlue
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var cloudsDescription: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.text = "Облачность"
        text.numberOfLines = 0
        text.textAlignment = .left
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var cloudsDayValue: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.numberOfLines = 0
        text.textAlignment = .right
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var riseImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "sunrise")
        image.tintColor = .specialBlue
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var riseDescription: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.text = "Восход"
        text.numberOfLines = 0
        text.textAlignment = .left
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var riseDayValue: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.numberOfLines = 0
        text.textAlignment = .right
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var setImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "sunset")
        image.tintColor = .specialBlue
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var setDescription: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.text = "Закат"
        text.numberOfLines = 0
        text.textAlignment = .left
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var setDayValue: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.numberOfLines = 0
        text.textAlignment = .right
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    private func setupView(){
        
        backgroundColor = .specialLightBlue
        addSubview(currentImage)
        addSubview(tempValue)
        addSubview(tempText)
        addSubview(tempImage)
        addSubview(tempDescription)
        addSubview(tempDayValue)
        addSubview(windImage)
        addSubview(windDescription)
        addSubview(windDayValue)
        addSubview(rainImage)
        addSubview(rainDescription)
        addSubview(rainDayValue)
        addSubview(cloudsImage)
        addSubview(cloudsDescription)
        addSubview(cloudsDayValue)
        addSubview(riseImage)
        addSubview(riseDescription)
        addSubview(riseDayValue)
        addSubview(setImage)
        addSubview(setDescription)
        addSubview(setDayValue)
        
        NSLayoutConstraint.activate([
            
            currentImage.topAnchor.constraint(equalTo: topAnchor),
            currentImage.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -50),
            currentImage.heightAnchor.constraint(equalToConstant: 50),
            currentImage.widthAnchor.constraint(equalToConstant: 50),
            
            tempValue.topAnchor.constraint(equalTo: topAnchor),
            tempValue.leadingAnchor.constraint(equalTo: currentImage.trailingAnchor, constant: 10),
            
            tempText.topAnchor.constraint(equalTo: tempValue.bottomAnchor, constant: 10),
            tempText.leadingAnchor.constraint(equalTo: tempValue.leadingAnchor),
            tempText.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            tempImage.topAnchor.constraint(equalTo: tempText.bottomAnchor, constant: 15),
            tempImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            tempImage.heightAnchor.constraint(equalToConstant: 22),
            tempImage.widthAnchor.constraint(equalToConstant: 22),
            
            tempDescription.topAnchor.constraint(equalTo: tempText.bottomAnchor, constant: 15),
            tempDescription.leadingAnchor.constraint(equalTo: tempImage.trailingAnchor, constant: 10),
            tempDescription.widthAnchor.constraint(equalToConstant: 125),
            tempDescription.heightAnchor.constraint(equalToConstant: 21),
            
            tempDayValue.topAnchor.constraint(equalTo: tempText.bottomAnchor, constant: 15),
            tempDayValue.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            tempDayValue.widthAnchor.constraint(equalToConstant: 50),
            tempDayValue.heightAnchor.constraint(equalToConstant: 21),
            
            windImage.topAnchor.constraint(equalTo: tempImage.bottomAnchor, constant: 15),
            windImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            windImage.heightAnchor.constraint(equalToConstant: 22),
            windImage.widthAnchor.constraint(equalToConstant: 22),
            
            windDescription.topAnchor.constraint(equalTo: tempDescription.bottomAnchor, constant: 15),
            windDescription.leadingAnchor.constraint(equalTo: windImage.trailingAnchor, constant: 10),
            windDescription.widthAnchor.constraint(equalToConstant: 50),
            windDescription.heightAnchor.constraint(equalToConstant: 21),
            
            windDayValue.topAnchor.constraint(equalTo: tempDayValue.bottomAnchor, constant: 15),
            windDayValue.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            windDayValue.widthAnchor.constraint(equalToConstant: 50),
            windDayValue.heightAnchor.constraint(equalToConstant: 21),
            
            rainImage.topAnchor.constraint(equalTo: windImage.bottomAnchor, constant: 15),
            rainImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            rainImage.heightAnchor.constraint(equalToConstant: 22),
            rainImage.widthAnchor.constraint(equalToConstant: 22),
            
            rainDescription.topAnchor.constraint(equalTo: windDescription.bottomAnchor, constant: 15),
            rainDescription.leadingAnchor.constraint(equalTo: rainImage.trailingAnchor, constant: 10),
            rainDescription.widthAnchor.constraint(equalToConstant: 60),
            rainDescription.heightAnchor.constraint(equalToConstant: 21),
            
            rainDayValue.topAnchor.constraint(equalTo: windDayValue.bottomAnchor, constant: 15),
            rainDayValue.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            rainDayValue.widthAnchor.constraint(equalToConstant: 50),
            rainDayValue.heightAnchor.constraint(equalToConstant: 21),
            
            cloudsImage.topAnchor.constraint(equalTo: rainImage.bottomAnchor, constant: 15),
            cloudsImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            cloudsImage.heightAnchor.constraint(equalToConstant: 21),
            cloudsImage.widthAnchor.constraint(equalToConstant: 22),
            
            cloudsDescription.topAnchor.constraint(equalTo: rainDescription.bottomAnchor, constant: 15),
            cloudsDescription.leadingAnchor.constraint(equalTo: cloudsImage.trailingAnchor, constant: 10),
            cloudsDescription.widthAnchor.constraint(equalToConstant: 100),
            cloudsDescription.heightAnchor.constraint(equalToConstant: 21),
            
            cloudsDayValue.topAnchor.constraint(equalTo: rainDayValue.bottomAnchor, constant: 15),
            cloudsDayValue.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            cloudsDayValue.widthAnchor.constraint(equalToConstant: 50),
            cloudsDayValue.heightAnchor.constraint(equalToConstant: 21),
            
            riseImage.topAnchor.constraint(equalTo: cloudsImage.bottomAnchor, constant: 10),
            riseImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            riseImage.heightAnchor.constraint(equalToConstant: 22),
            riseImage.widthAnchor.constraint(equalToConstant: 22),
            
            riseDescription.topAnchor.constraint(equalTo: cloudsDescription.bottomAnchor, constant: 15),
            riseDescription.leadingAnchor.constraint(equalTo: riseImage.trailingAnchor, constant: 10),
            riseDescription.widthAnchor.constraint(equalToConstant: 60),
            riseDescription.heightAnchor.constraint(equalToConstant: 21),
            
            riseDayValue.topAnchor.constraint(equalTo: cloudsDayValue.bottomAnchor, constant: 10),
            riseDayValue.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            riseDayValue.widthAnchor.constraint(equalToConstant: 50),
            riseDayValue.heightAnchor.constraint(equalToConstant: 21),
            
            setImage.topAnchor.constraint(equalTo: riseImage.bottomAnchor, constant: 10),
            setImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            setImage.heightAnchor.constraint(equalToConstant: 22),
            setImage.widthAnchor.constraint(equalToConstant: 22),
            
            setDescription.topAnchor.constraint(equalTo: riseDescription.bottomAnchor, constant: 10),
            setDescription.leadingAnchor.constraint(equalTo: setImage.trailingAnchor, constant: 10),
            setDescription.widthAnchor.constraint(equalToConstant: 60),
            setDescription.heightAnchor.constraint(equalToConstant: 21),
            
            setDayValue.topAnchor.constraint(equalTo: riseDayValue.bottomAnchor, constant: 15),
            setDayValue.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            setDayValue.widthAnchor.constraint(equalToConstant: 50),
            setDayValue.heightAnchor.constraint(equalToConstant: 21)
            
        ])
    }
    
    func setupCell(for data: AllWeatherData){
        
        currentImage.image = data.imageCollectionView
        tempValue.text = data.currentWeatherValue
        tempText.text = data.descriptionWeather
        tempDayValue.text = data.feels_like + "º"
        windDayValue.text = data.valueWind
        rainDayValue.text = data.valueRain
        cloudsDayValue.text = data.valueVisible
        riseDayValue.text = data.timeRise
        setDayValue.text = data.timeSunset
    }
    
}
