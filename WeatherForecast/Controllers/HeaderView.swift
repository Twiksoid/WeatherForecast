//
//  HeaderView.swift
//  WeatherForecast
//
//  Created by Nikita Byzov on 14.12.2022.
//

import UIKit
import Charts

class HeaderView: UITableViewHeaderFooterView {

    private lazy var titleTextField: UITextField = {
        let titleField = UITextField()
        titleField.textColor = .black
        titleField.font = .boldSystemFont(ofSize: 18)
        titleField.text = "Text"
        titleField.isUserInteractionEnabled = false
        titleField.translatesAutoresizingMaskIntoConstraints = false
        return titleField
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        addSubview(titleTextField)
        
        NSLayoutConstraint.activate([
            titleTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleTextField.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    func setupHeader(){}
}
