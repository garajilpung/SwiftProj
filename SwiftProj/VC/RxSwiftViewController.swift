//
//  RxSwiftViewController.swift
//  SwiftProj
//
//  Created by SMG on 2024/02/22.
//  Copyright © 2024 garajilpung. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

@objc(RxSwiftViewController)
class RxSwiftViewController: BasicViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        example(of: "just, of, from") {
            let one = 1
            let two = 2
            let three = 3
            
            let observable1:Observable<Int> = Observable<Int>.just(one)
            
            let observable2:Observable = Observable.of(one, two, three)
            let observable3:Observable = Observable.of([one, two, three])
            //
            let observable4:Observable = Observable.from([one, two, three])
            let observable5:Observable = Observable<Void>.empty()
            //
            //            let sequence = 0..<3
            //            var iterator = sequence.makeIterator()
            //            while let n = iterator.next() {
            //                print(n)
            //            }
            observable1.subscribe{ event in
                
                if let element = event.element {
                    print(element)
                }
            }
            
            //            observable4.subscribe { (element) in
            //                print(element)
            //            }
            //
            //            observable1.subscribe {
            //
            //            }
            
            //            observable1.subscribe({ (event) in
            //                print(event)
            //            })
            //
            //            observable2.subscribe({ (event) in
            //                print(event)
            //            })
            
            observable5.subscribe(
                onNext: { (element) in
                    print(element)
                },
                onError: { (error) in
                    print(error)
                },
                onCompleted: {
                    print("complete")
                },
                onDisposed: {
                    print("onDisposed")
                }
            )
        }
        
        
        example(of: "range") {
            let disposeBag = DisposeBag()
            //1
            let observable = Observable<Int>.range(start: 1, count: 10)
            
            observable
                .subscribe(
                onNext: { (element) in
                    let n = Double(element)
                    let fibonacci = Int(((pow(1.61803, n) - pow(0.61803, n)) / 2.23606).rounded())
                    print(fibonacci)
                }
                
//                onNext: { (i) in
//
//                    //2
//                    let n = Double(i)
//                    let fibonacci = Int(((pow(1.61803, n) - pow(0.61803, n)) / 2.23606).rounded())
//                    print(fibonacci)
//                })
                )
                .disposed(by: disposeBag)
            
        }
        
        example(of: "create") {
             let disposeBag = DisposeBag()
             
             Observable<String>.create({ (observer) -> Disposable in
                 // 1
                 observer.onNext("1")
                 
                 // 2
                 observer.onCompleted()
                 
                 // 3
                 observer.onNext("?")
                 
                 // 4
                 return Disposables.create()
             })
                 .subscribe(
                     onNext: { print($0) },
                     onError: { print($0) },
                     onCompleted: { print("Completed") },
                     onDisposed: { print("Disposed") }
             ).disposed(by: disposeBag)
         }
        
        example(of: "PublishSubject") {
             let subject = PublishSubject<String>()
             subject.onNext("Is anyone listening?")

             let subscriptionOne = subject
                 .subscribe(onNext: { (string) in
                     print(string)
                 })
             subject.on(.next("1"))
             subject.onNext("2")

             // 1
             let subscriptionTwo = subject
                 .subscribe({ (event) in
                     print("2)", event.element ?? event)
                 })

             // 2
             subject.onNext("3")
//
//             // 3
//             subscriptionOne.dispose()
//             subject.onNext("4")
//
//             // 4
//             subject.onCompleted()
//
//             // 5
//             subject.onNext("5")
//
//             // 6
//             subscriptionTwo.dispose()
//
//             let disposeBag = DisposeBag()
//
//             // 7
//             subject
//                 .subscribe {
//                     print("3)", $0.element ?? $0)
//             }
//                 .disposed(by: disposeBag)
//
//             subject.onNext("?")
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

    
    
    public func example(of description: String, action: () -> Void) {
        print("\n--- Example of:", description, "---")
        action()
    }
}
