//
//  KVOViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2021/03/08.
//  Copyright © 2021 garajilpung. All rights reserved.
//

import UIKit

@objcMembers class USER: NSObject {
    dynamic var strFirstName: String = ""
    dynamic var strLastName: String = ""
    dynamic var nAge: Int = 0
    
    func automaticallyNotifiesObservers(forKey key: String) -> Bool {
        if(key == "strLastName") {
            return false
        }else {
            return NSObject.automaticallyNotifiesObservers(forKey: key)
        }
    }
}





@objc(KVOViewController)
class KVOViewController: BasicViewController {

    private var playerItemObserverList: [NSKeyValueObservation] = []
    
    let cUser:USER = USER()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let playerItemObserver1 = cUser.observe(\.strFirstName, options: [.new , .old]) { (user, change) in
            guard let firstName = change.newValue else { return }
            print("firstName is: \(firstName)")
        }
        
         let playerItemObserver2 = cUser.observe(\.strLastName, options: [.new , .old]) { (user, change) in
            guard let lastName = change.newValue else { return }
            print("lastName is: \(lastName)")
        }
        
         let playerItemObserver3 = cUser.observe(\.nAge, options: [.new , .old]) { (user, change) in
            guard let age = change.newValue else { return }
            print("Age is: \(age)")
        }
        
        playerItemObserverList.append(playerItemObserver1)
        playerItemObserverList.append(playerItemObserver2)
        playerItemObserverList.append(playerItemObserver3)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        for obser in playerItemObserverList {
            obser.invalidate()
        }
        
        playerItemObserverList.removeAll()
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - UIButton Event
    @IBAction func onBtn1(_ sender: Any) {
        cUser.strFirstName = "veee";
    }
    
    @IBAction func onBtn2(_ sender: Any) {
        cUser.strLastName = "llassete";
    }
    
    @IBAction func onBtn3(_ sender: Any) {
        cUser.nAge = 80
        
        UpdateUI()
    }
    
    // MARK: - Custom Function
    public func ggetInt() -> Int {
        let queue = DispatchQueue.global()
        let group = DispatchGroup()
        var result: Int = 0
        
        let workItem = DispatchWorkItem {
            result = 3
            group.leave()
        }

        group.enter()
        queue.async(group: group, execute: workItem)
        group.wait()

        return result
    }
    
    func UpdateUI(){

        test { (data) in
          //data is value return by test function
            DispatchQueue.main.async {
                // Update UI
                //do task what you want.
                // run on the main queue, after the previous code in outer block
            }
        }

        aaa { (data)  in
            return 1
        }
    }

    func test (returnCompletion: @escaping (AnyObject) -> () ){

        let url = URL(string: "https://google.com/")
        DispatchQueue.global(qos: .background).async {
            // Background work
            let data = try? Data(contentsOf: url!)
            // convert the data in you formate. here i am using anyobject.
            returnCompletion(data as AnyObject)
        }
    }

    func aaa (returnCompletion: @escaping (AnyObject) -> Int ) {
        
        
        let url = URL(string: "https://google.com/")
        DispatchQueue.global(qos: .background).async {
            // Background work
            let data = try? Data(contentsOf: url!)
            // convert the data in you formate. here i am using anyobject.
            if( returnCompletion(data as AnyObject) != 1 ) {
                print("vvv")
            }else {
                print("fff")
            }
        }
        
    }
    
}
