//
//  DetailCell.swift
//  WeatherForecast
//
//  Created by Nikita Byzov on 14.12.2022.
//

import UIKit

class DetailCell: UITableViewCell {
    
    private lazy var dataText: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.numberOfLines = 0
        text.textAlignment = .left
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var timeText: UILabel = {
        let text = UILabel()
        text.textColor = .gray
        text.numberOfLines = 0
        text.textAlignment = .center
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var tempText: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.numberOfLines = 0
        text.textAlignment = .center
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var generalImage: UIImageView = {
        let image = UIImageView()
        image.tintColor = .specialBlue
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var generalText: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.numberOfLines = 0
        text.textAlignment = .left
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var windImage: UIImageView = {
        let image = UIImageView()
        image.tintColor = .specialBlue
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var windText: UILabel = {
        let text = UILabel()
        text.text = "Ветер"
        text.textColor = .black
        text.numberOfLines = 0
        text.textAlignment = .left
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var windValue: UILabel = {
        let text = UILabel()
        text.textColor = .gray
        text.numberOfLines = 0
        text.textAlignment = .right
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var rainImage: UIImageView = {
        let image = UIImageView()
        image.tintColor = .specialBlue
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var rainText: UILabel = {
        let text = UILabel()
        text.text = "Атмосферные осадки"
        text.textColor = .black
        text.numberOfLines = 0
        text.textAlignment = .left
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    private lazy var rainValue: UILabel = {
        let text = UILabel()
        text.textColor = .gray
        text.numberOfLines = 0
        text.textAlignment = .right
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var cloudImage: UIImageView = {
        let image = UIImageView()
        image.tintColor = .specialBlue
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var cloudText: UILabel = {
        let text = UILabel()
        text.text = "Облачность"
        text.textColor = .black
        text.numberOfLines = 0
        text.textAlignment = .left
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    private lazy var cloudValue: UILabel = {
        let text = UILabel()
        text.textColor = .gray
        text.numberOfLines = 0
        text.textAlignment = .right
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        contentView.addSubview(dataText)
        contentView.addSubview(timeText)
        contentView.addSubview(tempText)
        contentView.addSubview(generalImage)
        contentView.addSubview(generalText)
        contentView.addSubview(windImage)
        contentView.addSubview(windText)
        contentView.addSubview(windValue)
        contentView.addSubview(rainImage)
        contentView.addSubview(rainText)
        contentView.addSubview(rainValue)
        contentView.addSubview(cloudImage)
        contentView.addSubview(cloudText)
        contentView.addSubview(cloudValue)
        
        NSLayoutConstraint.activate([
            
            dataText.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            dataText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            dataText.heightAnchor.constraint(equalToConstant: 22),
            dataText.widthAnchor.constraint(equalToConstant: 100),
            
            timeText.topAnchor.constraint(equalTo: dataText.bottomAnchor),
            timeText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            timeText.heightAnchor.constraint(equalToConstant: 22),
            timeText.widthAnchor.constraint(equalToConstant: 50),
            
            tempText.topAnchor.constraint(equalTo: timeText.bottomAnchor),
            tempText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            tempText.heightAnchor.constraint(equalToConstant: 22),
            
            generalImage.topAnchor.constraint(equalTo: dataText.bottomAnchor),
            generalImage.trailingAnchor.constraint(equalTo: dataText.trailingAnchor),
            generalImage.heightAnchor.constraint(equalToConstant: 21),
            generalImage.widthAnchor.constraint(equalToConstant: 21),
            
            generalText.leadingAnchor.constraint(equalTo: generalImage.trailingAnchor, constant: 10),
            generalText.centerYAnchor.constraint(equalTo: generalImage.centerYAnchor),
            generalText.heightAnchor.constraint(equalToConstant: 22),
            generalText.widthAnchor.constraint(equalToConstant: frame.width - 70),
            
            windImage.topAnchor.constraint(equalTo: generalImage.bottomAnchor, constant: 5),
            windImage.leadingAnchor.constraint(equalTo: generalImage.leadingAnchor),
            windImage.trailingAnchor.constraint(equalTo: generalImage.trailingAnchor),
            windImage.heightAnchor.constraint(equalToConstant: 21),
            
            windText.leadingAnchor.constraint(equalTo: windImage.trailingAnchor, constant: 10),
            windText.centerYAnchor.constraint(equalTo: windImage.centerYAnchor),
            windText.heightAnchor.constraint(equalToConstant: 22),
            windText.widthAnchor.constraint(equalToConstant: frame.width - 70),
            
            windValue.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            windValue.centerYAnchor.constraint(equalTo: windText.centerYAnchor),
            windValue.heightAnchor.constraint(equalToConstant: 20),
            
            rainImage.topAnchor.constraint(equalTo: windImage.bottomAnchor, constant: 5),
            rainImage.leadingAnchor.constraint(equalTo: windImage.leadingAnchor),
            rainImage.trailingAnchor.constraint(equalTo: windImage.trailingAnchor),
            rainImage.heightAnchor.constraint(equalToConstant: 21),
            
            rainText.leadingAnchor.constraint(equalTo: rainImage.trailingAnchor, constant: 10),
            rainText.centerYAnchor.constraint(equalTo: rainImage.centerYAnchor),
            rainText.heightAnchor.constraint(equalToConstant: 22),
            rainText.widthAnchor.constraint(equalToConstant: frame.width - 70),
            
            rainValue.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            rainValue.centerYAnchor.constraint(equalTo: rainText.centerYAnchor),
            rainValue.heightAnchor.constraint(equalToConstant: 20),
            
            cloudImage.topAnchor.constraint(equalTo: rainImage.bottomAnchor, constant: 5),
            cloudImage.leadingAnchor.constraint(equalTo: rainImage.leadingAnchor),
            cloudImage.trailingAnchor.constraint(equalTo: rainImage.trailingAnchor),
            cloudImage.heightAnchor.constraint(equalToConstant: 21),
            
            cloudText.leadingAnchor.constraint(equalTo: cloudImage.trailingAnchor, constant: 10),
            cloudText.centerYAnchor.constraint(equalTo: cloudImage.centerYAnchor),
            cloudText.heightAnchor.constraint(equalToConstant: 22),
            cloudText.widthAnchor.constraint(equalToConstant: frame.width - 70),
            
            cloudValue.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            cloudValue.centerYAnchor.constraint(equalTo: cloudText.centerYAnchor),
            cloudValue.heightAnchor.constraint(equalToConstant: 20)
        ])
        
    }
    
    func setupCell(for dataForDay: DataForDay) {
        dataText.text = dataForDay.dataWeather
        timeText.text = dataForDay.textTimeWeather
        tempText.text = dataForDay.currentWeatherValue + "º"
        generalImage.image = dataForDay.imageGeneral
        generalText.text = dataForDay.descriptionWeather + " и " + dataForDay.currentWeatherValue + "º"
        windImage.image = dataForDay.imageWind
        windValue.text = dataForDay.valueWind
        rainImage.image = dataForDay.imageRain
        rainValue.text = dataForDay.valueWind
        cloudImage.image = dataForDay.imageVisible
        cloudValue.text = dataForDay.valueVisible
    }
    
}
