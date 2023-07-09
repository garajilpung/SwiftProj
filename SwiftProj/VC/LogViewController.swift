//
//  LogViewController.swift
//  SwiftProj
//
//  Created by SMG on 2022/06/13.
//  Copyright © 2022 garajilpung. All rights reserved.
//

import UIKit

@objc(LogViewController)
class LogViewController: BasicViewController {

    let age : Int = -2
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBAction func onBtn1(_ sender: Any) {
        assert(age >= 0, "A person's age can't be less than zero.")
    }
    
    @IBAction func onBtn2(_ sender: Any) {
        if age > 10 {
            print("You can ride the roller-coaster or the ferris wheel.")
        } else if age >= 0 {
            print("You can ride the ferris wheel.")
        } else {
            assertionFailure("A person's age can't be less than zero.")
        }
    }
    
    @IBAction func onBtn3(_ sender: Any) {
        precondition(age > 0, "Index must be greater than zero.")
    }
    
    @IBAction func onBtn4(_ sender: Any) {
        
        if age > 10 {
            print("You can ride the roller-coaster or the ferris wheel.")
        } else if age >= 0 {
            print("You can ride the ferris wheel.")
        } else {
            preconditionFailure("A person's age can't be less than zero.")
        }
        
    }
}
