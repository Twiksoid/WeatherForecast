//
//  ExtendedWeatherDataController.swift
//  WeatherForecast
//
//  Created by Nikita Byzov on 13.12.2022.
//

import UIKit

class ExtendedWeatherDataController: UIViewController {
    
    var delegateWeatherDataController: WeatherDataController?
    var cityID: Int32?
    var country: String?
    var dayForCity: String?
    var allWeatherData = [AllWeatherData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allWeatherData = CoreDataManager.shared.catchData(for: cityID ?? 0, and: country ?? "ru")
        setupView()
    }
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.rowHeight = UITableView.automaticDimension
        table.dataSource = self
        table.delegate = self
        table.register(HeaderDate.self, forHeaderFooterViewReuseIdentifier: NamesOfCells.headerDate)
        table.register(WeatherCardCell.self, forCellReuseIdentifier: NamesOfCells.weatherCardCell)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private func setupView(){
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
}

extension ExtendedWeatherDataController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: NamesOfCells.headerDate) as? HeaderDate {
                let index = allWeatherData.firstIndex(where: { $0.dataWeather == dayForCity })
                // найдем первую запись для выбранного дня
                headerView.setupHeaderData(for: allWeatherData[index ?? 0].dataWeather)
                return headerView
            } else {
                return nil
            }
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 270
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: NamesOfCells.weatherCardCell, for: indexPath) as? WeatherCardCell {
            // найдем первую запись для выбранного дня
            let index = allWeatherData.firstIndex(where: { $0.dataWeather == dayForCity })
            cell.setupCell(for: allWeatherData[index ?? 0])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Default")!
            return cell
        }
    }
    
    
}
