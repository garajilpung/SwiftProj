//
//  Person.swift
//  SwiftProj
//
//  Created by suhyup02 on 2021/03/15.
//  Copyright © 2021 garajilpung. All rights reserved.
//

import UIKit

class Person: NSObject {

    @objc var lastName : String = ""
    @objc var firstName : String = ""
    @objc var nAge : Int = 0
    @objc var bStudent : Bool = false
    @objc var toy : Array = Array<String>()
    
    init(dic : Dictionary<String, Any>) {
        super.init()

        for (_, value) in dic.enumerated() {
            print("value \(value.value) key : \(value.key)")
            self.setValue(value.value , forKey: value.key)
        }
        
    }
    
    func desc()->Void {
        print("lastName \(lastName)")
        print("firstName \(firstName)")
        print("nAge \(nAge)")
        print("bStudent \(bStudent)")
        print("toy \(toy)")
    }
}

struct PP {
    var ch1 : [Character]   = [Character](repeating: "\0", count: 64)
    var ch2 : [Character]   = [Character](repeating: "\0", count: 32)
    var data : [Int8]       = [Int8](repeating: 0, count: 8)
    var ch4 : [Character]   = [Character](repeating: "\0", count: 16)
    var ch5 : [Character]   = [Character](repeating: "\0", count: 16)
}


struct PersonSC : Codable {
    let lastName : String?
    let firstName : String?
    let nAge : Int?
    let bStudent : Bool?
    let toy : Array<String>?
}

struct PersonCC : Codable {
    let lastName : String?
    let firstName : String?
    let nAge : Int?
    let bStudent : Bool?
    var toy : Array<String>? = nil
    
    init (pLastName: String?, pFirstName: String?, pAge : Int?, bStu : Bool?, pToy : Array<String>?) {
        self.lastName = pLastName
        self.firstName = pFirstName
        self.nAge = pAge
        self.bStudent = bStu
//        self.toy = pToy
    }
    
    func desc()->Void{
        print("lastName \(lastName!)")
        print("firstName \(firstName!)")
        print("nAge \(nAge!)")
        print("bStudent \(bStudent!)")
        print("toy \(toy!)")
    }
}
