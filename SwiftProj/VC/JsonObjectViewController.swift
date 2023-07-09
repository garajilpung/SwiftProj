//
//  JsonObjectViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2021/03/15.
//  Copyright © 2021 garajilpung. All rights reserved.
//

import UIKit

@objc(JsonObjectViewController)
class JsonObjectViewController: BasicViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let dic1 = ["lastName":"Johe", "firstName":"Smith", "nAge": NSNumber(value: 38), "bStudent":NSNumber(value: false) , "toy":["1","2","3"]] as [String : Any]
        
        let p1 : Person = Person(dic: dic1)
        p1.desc()
        
        let dic2 = ["lastName":"vvv", "firstName":"한국", "nAge": NSNumber(value: 11), "bStudent":NSNumber(value: true)] as [String : Any]
        
        
        let p2 : Person = Person(dic: dic2)
        p2.desc()
        
        
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys, .prettyPrinted]

        let zedd = PersonSC(lastName: "vv2", firstName: "v5666", nAge: 13, bStudent: true, toy: ["3","4","5"])
     
        let jsonData = try? encoder.encode(zedd)
        if let jsonData = jsonData,let jsonString = String(data: jsonData, encoding: .utf8){
            print(jsonString)
        }
        
        let zeddc = PersonCC(pLastName: "vv3", pFirstName: "vv6", pAge: 17, bStu: true, pToy: nil)
        
        let jsonData2 = try? encoder.encode(zeddc)
        if let _ = jsonData2,let jsonString = String(data: jsonData2!, encoding: .utf8){
            print(jsonString)
        }
        
        let jsonString = """
        {
        "firstName" : "vvvv56",
        "lastName" : "8888"
        "nAge": 28
        "bStucent" : FALSE
        "toy" : ["9","11","12"]
        }
        """
        let decoder = JSONDecoder()
        
        var data = jsonString.data(using: .utf8)
        if let data = data, let myPerson = try? decoder.decode(PersonCC.self, from: data) {
            myPerson.desc()
        }
     }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
