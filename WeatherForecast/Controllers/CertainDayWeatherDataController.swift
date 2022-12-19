//
//  CertainDayWeatherDataController.swift
//  WeatherForecast
//
//  Created by Nikita Byzov on 13.12.2022.
//

import UIKit

class CertainDayWeatherDataController: UIViewController {
    
    var delegateWeatherDataController: WeatherDataController?
    var cityID: Int32?
    var dataForCity = [DataForDay]()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.dataSource = self
        table.delegate = self
        table.layer.cornerRadius = 10
        table.clipsToBounds = true
        table.rowHeight = UITableView.automaticDimension
        table.register(DetailCell.self, forCellReuseIdentifier: "DetailCell")
        table.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: NamesOfCells.headerView)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        if cityID != nil {
            dataForCity = CoreDataManager.shared.getDataForCertainTown(for: cityID!)
            print(dataForCity.count)
            tableView.reloadData()
        }
    }
    
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

extension CertainDayWeatherDataController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataForCity.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: NamesOfCells.headerView) as? HeaderView {
                headerView.setupHeader(for: dataForCity)
                return headerView
            } else {
                return nil
            }
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as? DetailCell {
            cell.layer.cornerRadius = 10
            cell.clipsToBounds = true
            cell.backgroundColor = .specialLightBlue
            cell.setupCell(for: dataForCity[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Default")!
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
}
