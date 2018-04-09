//
//  CurrencyInfoViewController.swift
//  Crypto Info
//
//  Created by Jaskirat Singh on 03/04/18.
//  Copyright © 2018 jassie. All rights reserved.
//

import UIKit
import SwiftCharts

class CurrencyInfoViewController: UIViewController {

    // MARK: IBOutlets
    
    @IBOutlet weak var graphView: UIView!
    @IBOutlet weak var symbol: UILabel!
    @IBOutlet weak var currencyName: UITextField!
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var change1Hr: UITextField!
    @IBOutlet weak var change24Hr: UITextField!
    @IBOutlet weak var change1Week: UITextField!
    
    var chartView:  BarsChart!
    var arrayChange: [String] = []
    var oneHr: String = ""
    var twentyFourHr: String = ""
    var oneWeek: String = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        
        if ConnectionCheck.isConnectedToNetwork() == true
        {
            print("Internet connection OK")
        }
        else
        {
            print("Internet connection FAILED")
            let alert = UIAlertController(title: "Alert", message: "No Internet Connection!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: {    (action:UIAlertAction!) in
                print("you have pressed the Cancel button")
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
        self.navigationController?.isNavigationBarHidden = false
        
        oneHr = arrayChange[0]
        twentyFourHr = arrayChange[1]
        oneWeek = arrayChange[2]
        
        self.graph()
        
        self.change1Hr.text = "$ " + arrayChange[0]
        self.change24Hr.text = "$ " + arrayChange[1]
        self.change1Week.text = "$ " + arrayChange[2]
        self.symbol.text = arrayChange[3]
        self.currencyName.text = arrayChange[4]
        self.amount.text = "$ " + arrayChange[5]
    }
        
    func graph()
    {
        var firstHour = Double(oneHr)
        var fullDay = Double(twentyFourHr)
        var fullWeek = Double(oneWeek)
        
        if firstHour! < 0.0
        {
            firstHour = -firstHour!
        }
        if fullDay! < 0.0
        {
            fullDay = -fullDay!
        }
        if fullWeek! < 0.0
        {
            fullWeek = -fullWeek!
        }
        
        let chart = BarsChartConfig(valsAxisConfig: ChartAxisConfig(from: 0.0, to: 100, by: 10))
        let chartView = CGRect(x: 0, y: 0, width: self.graphView.frame.width, height: self.graphView.frame.height)
        
        let graphChart = BarsChart(frame: chartView, chartConfig: chart, xTitle: "Time-Period", yTitle: "Chane in U.S Dollars", bars: [("1-H", firstHour!), ("24-H", fullDay!), ("7-D", fullWeek!)], color: UIColor.white, barWidth: 30)
        
        self.graphView.addSubview(graphChart.view)
        self.chartView = graphChart
        
    }
  
}

