//
//  ChartsViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2022/02/16.
//  Copyright © 2022 garajilpung. All rights reserved.
//

import UIKit
import Charts

@objc(ChartsViewController)
class ChartsViewController: BasicViewController {

    @IBOutlet weak var barChartsView: BarChartView!
    @IBOutlet weak var combinedChartView: CombinedChartView!
    
    //Bar Data
    var months: [String]!
    var unitsSold: [Double]!
    //Bar Data
    
    // CombineData
    var graphArray: [String] = ["09시", "10시", "11시", "12시", "13시", "14시", "15시", "16시", "17시", "18시"]
    let barUnitsSold = [10.0, 17.0, 9.0, 1.0, 8.0, 13.0, 16.0, 14.0, 7.0, 1.0]
    let lineUnitsSold = [10.0, 18.0, 7.0, 1.0, 5.0, 15.0, 14.0, 17.0, 7.0, 1.0]
    //Combine Data
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        
        barChartsView.noDataText = "데이터가 없습니다."
        barChartsView.noDataFont = .systemFont(ofSize: 20)
        barChartsView.noDataTextColor = .lightGray
        
        setBarChart(dataPoints: months, values: unitsSold)
        
//        setCombineChart(dataPoints: graphArray, barValues: barUnitsSold, lineValues: lineUnitsSold)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func setBarChart(dataPoints: [String], values: [Double]) {
        // 데이터 생성
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "판매량")
        
        // 차트 컬러
        chartDataSet.colors = [.systemBlue]
        
        // 데이터 삽입
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartsView.data = chartData
        
        /*
        // 선택 안되게
        chartDataSet.highlightEnabled = false
        // 줌 안되게
        barChartsView.doubleTapToZoomEnabled = false


        // X축 레이블 위치 조정
        barChartsView.xAxis.labelPosition = .bottom
        // X축 레이블 포맷 지정
        barChartsView.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)

        
        // X축 레이블 갯수 최대로 설정 (이 코드 안쓸 시 Jan Mar May 이런식으로 띄엄띄엄 조금만 나옴)
        barChartsView.xAxis.setLabelCount(dataPoints.count, force: false)
        
        // 오른쪽 레이블 제거
        barChartsView.rightAxis.enabled = false
        
        // 기본 애니메이션
        barChartsView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        // 옵션 애니메이션
        //barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)


        // 리미트라인
        let ll = ChartLimitLine(limit: 10.0, label: "타겟")
        barChartsView.leftAxis.addLimitLine(ll)


        // 맥시멈
        barChartsView.leftAxis.axisMaximum = 30
        // 미니멈
        barChartsView.leftAxis.axisMinimum = -10

        
        // 백그라운드컬러
        barChartsView.backgroundColor = .yellow
     */
    }
    
    
    func setCombineChart(dataPoints: [String], barValues: [Double], lineValues: [Double]) {
            
        // bar, line 엔트리 생성
        var barDataEntries: [BarChartDataEntry] = []
        var lineDataEntries: [ChartDataEntry] = []
        
        // bar, line 엔트리 삽입
        for i in 0..<dataPoints.count {
            let barDataEntry = BarChartDataEntry(x: Double(i), y: barValues[i])
            let lineDataEntry = ChartDataEntry(x: Double(i), y: lineValues[i])
            barDataEntries.append(barDataEntry)
            lineDataEntries.append(lineDataEntry)
        }

        // 데이터셋 생성
        let barChartDataSet = BarChartDataSet(entries: barDataEntries, label: "목표 처리량")
        let lineChartDataSet = LineChartDataSet(entries: lineDataEntries, label: "실시간 처리량")
 
        // 라인 원 색깔 변경
        lineChartDataSet.colors = [.red ]
        lineChartDataSet.circleColors = [.red ]
        
        
        // 데이터 생성
        let data: CombinedChartData = CombinedChartData()
        
        // bar 데이터 지정
        data.barData = BarChartData(dataSet: barChartDataSet)
        // line 데이터 지정
        data.lineData = LineChartData(dataSet: lineChartDataSet)
        
        // 콤비 데이터 지정
        combinedChartView.data = data
        
        // X축 레이블 포맷 ( index -> 실제데이터 )
        combinedChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: graphArray)


        // 라인 굵기
        lineChartDataSet.lineWidth = 5.0
        
        // 원 구멍 반경
        lineChartDataSet.circleHoleRadius = 5.0

        // 원 반경 (꽉채우려면 홀 반경이랑 똑같게)
        lineChartDataSet.circleRadius = 5.0

        lineChartDataSet.mode = .cubicBezier

        // 기본 애니메이션
        combinedChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        // 옵션 애니메이션
        //combinedChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
        
        
        // 바 컬러
        barChartDataSet.colors = [.systemBlue ]
        // 백그라운드 컬러
        combinedChartView.backgroundColor = .yellow
        
        // X축 레이블 전체 보이도록 설정 ( 09시, 10시, 11시 ... )
        combinedChartView.xAxis.setLabelCount(graphArray.count, force: true)
        // X축 레이블 위치 조정
        combinedChartView.xAxis.labelPosition = .bottom
        
        
        // 맥시멈
        combinedChartView.leftAxis.axisMaximum = 25
        // 미니멈
        combinedChartView.leftAxis.axisMinimum = -5
        
        
        // 리미트 라인 생성
        combinedChartView.leftAxis.addLimitLine(ChartLimitLine(limit: 10, label: "평균"))
        // 우측 레이블 제거
        combinedChartView.rightAxis.enabled = false

        
        // 차트 선택 안되게
        lineChartDataSet.highlightEnabled = false
        barChartDataSet.highlightEnabled = false
        
        // 줌 안되게
        combinedChartView.doubleTapToZoomEnabled = false
    }
}
