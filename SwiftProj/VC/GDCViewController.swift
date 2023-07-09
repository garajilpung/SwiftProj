//
//  GDCViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2020/11/25.
//  Copyright © 2020 garajilpung. All rights reserved.
//

import UIKit

@objc(GDCViewController)
class GDCViewController: BasicViewController {

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        queue1()
        queue2()
        
        queue3()
        
        queueGroup()
        queueGroup2()
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - 직렬큐
    func queue1() ->Void {
        DispatchQueue.global().sync {
            print("Done 1")
        }
        
        DispatchQueue.global().sync {
            print("Done 2")
        }
        
        DispatchQueue.global().sync {
            print("Done 3")
        }
    }
    
    // MARK: - 병렬큐
    func queue2() ->Void {
        DispatchQueue.global().async {
            print("Done 1")
        }
        
        DispatchQueue.global().async {
            print("Done 2")
        }
        
        DispatchQueue.global().async {
            print("Done 3")
        }
    }
    
    func queue3() ->Void {
        DispatchQueue(label: "vvvv").async {
            print("Done 1")
        }
        
        DispatchQueue(label: "vvvv").async {
            print("Done 2")
        }
        
        DispatchQueue(label: "vvvv").async {
            print("Done 3")
        }
    }
    
    
    func queue4() ->Void {
        // 메인큐
        DispatchQueue.main.async { }
    }
    
    func queue5() ->Void {
        // GlobalQueue 생성
        DispatchQueue.global().sync { } // DispatchQos.QoSClass = default
        DispatchQueue.global(qos: .background).async { }
    }
    
    func queue6() ->Void {
           // Custom Dispatch Queue 생성
           // Serial Queue
           DispatchQueue(label: "com.myQueue").async { }
           DispatchQueue(label: "com.myQueue").sync { }

           // Concurrent Queue
            DispatchQueue(label: "com.myQueue", qos: .default, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil).async {
            
            }
     }
    
    func queue7() ->Void {
        //asyncAfter
        // Second 단위는 Double
        // deadline 의 타입은 DispatchTime
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { }

        /* enum DispatchTimeInterval: Equatable { case seconds(Int) case milliseconds(Int) case microseconds(Int) case nanoseconds(Int) case never public static func == (lhs: DispatchTimeInterval, rhs: DispatchTimeInterval) -> Bool } */
        // 더 자세하게 하고싶다면
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            
        }
    }
    
    func queueGroup() {
        let animationGroup = DispatchGroup()

        // enter
        animationGroup.enter()
        UIView.animate(withDuration: 1.5) {
            self.view1.backgroundColor = .blue
        } completion: { _ in

            // leave
            animationGroup.leave()
        }

        // enter
        animationGroup.enter()
        UIView.animate(withDuration: 3) {
            self.view2.backgroundColor = .green
        } completion: { _ in

            // leave
            animationGroup.leave()
        }

        // notify
        animationGroup.notify(queue: .main) {
            print("animation close")
        }
    }
    
    func queueGroup2() {
        let queue1 = DispatchQueue(label: "queue1", attributes: .concurrent)
        let queue2 = DispatchQueue(label: "queue2", attributes: .concurrent)

        let group = DispatchGroup()
        queue1.async(group: group) {
            for i in 0...5 {
                print(i)
            }
        }
        queue2.async(group: group) {
            for i in 100...105 {
                print(i)
            }
        }

        let queueForGroup = DispatchQueue(label: "queue3", attributes: .concurrent)
        group.notify(queue: queueForGroup) { // group이 끝난 후 후행 클로저를 실행할 queue삽입
            print("끝")
        }
    }
}
