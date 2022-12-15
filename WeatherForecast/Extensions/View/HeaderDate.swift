//
//  HeaderDate.swift
//  WeatherForecast
//
//  Created by Nikita Byzov on 15.12.2022.
//

import UIKit

class HeaderDate: UITableViewHeaderFooterView {

    private lazy var titleTextField: UITextField = {
        let titleField = UITextField()
        titleField.textColor = .black
        titleField.textAlignment = .center
        titleField.font = .boldSystemFont(ofSize: 18)
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
            
            titleTextField.topAnchor.constraint(equalTo: topAnchor),
            titleTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleTextField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupHeaderData(for date: String){
        titleTextField.text = date
    }
}
