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
        chart.xAxis.labelWidth = CGFloat(11)
        chart.xAxis.labelHeight = CGFloat(11)
        chart.xAxis.labelFont = .boldSystemFont(ofSize: 14)
        
        chart.xAxis.labelTextColor = .black
        chart.xAxis.axisLineColor = .white
        chart.animate(xAxisDuration: 1.0)
        chart.legend.enabled = false
        chart.sizeToFit()
        chart.backgroundColor = .specialLightBlue
        return chart
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
            
            let stringTemp = i.currentWeatherValue
            let numberTemp = Double(stringTemp)
            
            arrayOfSetData.append(ChartDataEntry(
                x: numberTime ?? 0.0,
                y: numberTemp ?? 0.0,
                icon: i.imageGeneral))
        }
        
        let setOfValues = LineChartDataSet(entries: arrayOfSetData)
        setOfValues.drawCirclesEnabled = false
        // плавная линия
        setOfValues.mode = .horizontalBezier
        setOfValues.setColor(.specialLightBlue)
        setOfValues.formSize = CGFloat(11)
        setOfValues.drawHorizontalHighlightIndicatorEnabled = false
        setOfValues.highlightColor = .black
        setOfValues.drawIconsEnabled = true
        
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
