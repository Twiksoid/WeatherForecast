//
//  HeaderView.swift
//  WeatherForecast
//
//  Created by Nikita Byzov on 14.12.2022.
//

import UIKit
import Charts

class HeaderView: UITableViewHeaderFooterView {
    
  private lazy var lineChart: LineChartView = {
        let chart = LineChartView()
        chart.translatesAutoresizingMaskIntoConstraints = false
        chart.rightAxis.enabled = false
        chart.leftAxis.enabled = false
      
        chart.xAxis.labelPosition = .bottom
        chart.xAxis.labelFont = .boldSystemFont(ofSize: 12)
        
        chart.xAxis.labelTextColor = .black
        chart.xAxis.axisLineColor = .white
        chart.animate(xAxisDuration: 1.0)
        chart.legend.enabled = false
        chart.backgroundColor = .specialLightBlue
        return chart
    }()

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
        addSubview(lineChart)
        
        NSLayoutConstraint.activate([
            
            lineChart.topAnchor.constraint(equalTo: topAnchor),
            lineChart.leadingAnchor.constraint(equalTo: leadingAnchor),
            lineChart.trailingAnchor.constraint(equalTo: trailingAnchor),
            lineChart.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupHeader(for dataForCity: [DataForDay]){

        var arrayOfSetData = [ChartDataEntry]()
        lineChart.xAxis.setLabelCount(dataForCity.count, force: false)
        
        for i in dataForCity {
            
            let stringTime = i.textTimeWeather
            let numberTime = Double(stringTime.dropLast(3))
            
            arrayOfSetData.append(ChartDataEntry(
                x: numberTime ?? 0.0,
                y: Double(i.currentWeatherValue) ?? 0.0))
        }
        
        let setOfValues = LineChartDataSet(entries: arrayOfSetData)
        setOfValues.drawCirclesEnabled = false
        // плавная линия
        setOfValues.mode = .horizontalBezier
        setOfValues.setColor(.black)
        setOfValues.drawHorizontalHighlightIndicatorEnabled = false
        setOfValues.highlightColor = .black
        
        let date = LineChartData(dataSet: setOfValues)
        // покахать значения º
        date.setDrawValues(true)
        lineChart.data = date
        
    }
}

extension HeaderView: ChartViewDelegate {
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
    }
}
