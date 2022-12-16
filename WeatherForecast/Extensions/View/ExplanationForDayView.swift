//
//  ExplanationForDayView.swift
//  WeatherForecast
//
//  Created by Nikita Byzov on 14.12.2022.
//

import UIKit

class ExplanationForDayView: UICollectionReusableView, UIGestureRecognizerDelegate {
    
    // для работы гистуры нужна ссылка на вью, с которого хотим уйти на новое
    weak var delegate: WeatherDataController?
    var dataForExtension: [TextData]?
    
    private lazy var label: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .black
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.sizeToFit()
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showdetails)))
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    @objc func showdetails(){
        let viewNameToGo = CertainDayWeatherDataController()
        // поскольку прокидываем конкретный массив данных, то можно так сделать
        viewNameToGo.cityID = dataForExtension?[0].cityID
        
        delegate?.navigationController?.pushViewController(viewNameToGo, animated: true)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        addSubview(label)
        
        NSLayoutConstraint.activate([
            
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    }
    
    func setupCollectionHeader(forIndex index: Int, and name: String) {
        switch index {
        case 0:
            label.text = name
            label.textAlignment = .center
        case 1:
            label.text = Constants.textFor24Hours
        case 2:
            label.text = Constants.textForEveryDay
            label.textAlignment = .left
            label.isUserInteractionEnabled = false
        default:
            label.text = Constants.nilField
        }
    }
}
