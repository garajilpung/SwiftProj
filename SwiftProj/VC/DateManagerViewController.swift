//
//  DateManagerViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2020/12/03.
//  Copyright © 2020 garajilpung. All rights reserved.
//

import UIKit

@objc(DateManagerViewController)
class DateManagerViewController: BasicViewController {

    @IBOutlet weak var lbText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        control()
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - User Method
    
    func control() -> Void{
        var content : String! = ""
        let df : DateFormatter! = DateFormatter.init()
        
        let toDay = Date.init()
        content.append(toDay.description)
        content.append("\n")
        
        
        content.append(String.init(format:"%f", toDay.timeIntervalSinceReferenceDate))
        content.append("\n")
        
        df.timeStyle = .short
        df.dateStyle = .short
        
        content.append(df.string(from: toDay))
        content.append("\n")
        
        df.timeStyle = .full
        df.dateStyle = .full
        
        content.append(df.string(from: toDay))
        content.append("\n")
        
        df.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z' EEE"
        
        content.append(df.string(from: toDay))
        content.append("\n")
        
        lbText.text = content
        
        var ndf = DateFormatter().dateFormat = "yyyy'-'MM'-'dd'"
        
        var date = Date()
        
        var weekRange = Calendar.current.range(of: .weekOfMonth, in: Calendar.Component.month, for: date)
        print("count weak of count : ", weekRange?.lowerBound as Any , ", ", weekRange?.upperBound as Any )
        
        var dayRange = Calendar.current.range(of: .day, in: Calendar.Component.month, for: date)
        print("count weak of count : ", dayRange?.lowerBound as Any , ", ", dayRange?.upperBound as Any )
        
        var weekday = Calendar.current.range(of: .weekday, in: Calendar.Component.weekOfMonth, for: date)
        print("count weak of count : ", weekday?.lowerBound as Any , ", ", weekday?.upperBound as Any )
        
        date = Calendar.current.date(byAdding: .month, value: -7, to: Date())!
        
        weekRange = Calendar.current.range(of: .weekOfMonth, in: Calendar.Component.month, for: date)
        print("count weak of count : ", weekRange?.lowerBound as Any , ", ", weekRange?.upperBound as Any )
    
        dayRange = Calendar.current.range(of: .day, in: Calendar.Component.month, for: date)
        print("count weak of count : ", dayRange?.lowerBound as Any , ", ", dayRange?.upperBound as Any )
        
        weekday = Calendar.current.range(of: .weekday, in: Calendar.Component.weekOfMonth, for: date)
        print("count weak of count : ", weekday?.lowerBound as Any , ", ", weekday?.upperBound as Any )
        
        let comps : DateComponents! = Calendar.current.dateComponents([.year, .month, .day, .weekday, .weekOfMonth], from: date)
        
        if let comp1s = comps {
            print("dateComponents \(comp1s.year!), \(comp1s.month!), \(comp1s.day!), \(comp1s.weekday!), \(comp1s.weekOfMonth!) ")
        }else {
            print("값이 존하지 않음")
        }
        
        var comp1 = DateComponents()
        comp1.year = comps.year
        comp1.month = comps.month
        comp1.day = 1
        
        let date1 = Calendar.current.date(from: comp1)
        let weekday1 = Calendar.current.ordinality(of: .weekday, in: Calendar.Component.weekOfMonth, for: date1!)
     
        print("weekday : \(weekday1!)")
    }
    
}
