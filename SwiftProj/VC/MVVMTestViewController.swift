//
//  GoodsViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2022/02/17.
//  Copyright © 2022 garajilpung. All rights reserved.
//

import UIKit

@objc(MVVMTestViewController)
class MVVMTestViewController: BasicViewController {

    private var goodsData_VM : BODY_GOODSDATA_VM!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        recevieData()
        receiveData2()
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - Network
    private func recevieData() {
        
        sendASyncRequest(pURLString: "https://mtest.suhyup-bank.com:9190/ib20/act/FIL19826", pDicBody: nil) { bSuccess, errorMsg, result in
            
            if(bSuccess) {
//                print("response Data : ", result)
                do {
//                    let msg = try JSONDecoder().decode(SUHYUP_DATA_MSG.self, from: result!)
//
//                    print("suhyupDAta : " ,msg._msg_._body_)
//                    print("suhyupDAta : " ,msg._msg_._common_)
                    
                }catch {
                    print("json error", error.localizedDescription)
                }
                
//                guard let dicBody = dic["_msg_"] as? Dictionary<> else {
//                    return
//                }
//
//                print("dicBody : ", dicBody)
                
            }else {
                let alertVC = UIAlertController.init(title: "알림", message: errorMsg, preferredStyle: UIAlertController.Style.alert)
                let btnOK = UIAlertAction.init(title: "확인", style: UIAlertAction.Style.default) { action in
                }
                
                alertVC.addAction(btnOK)
                
                self.present(alertVC, animated: true, completion: {
                    
                })
            }
        }
        
    }
    
    private func receiveData2() {
        sendSuhyupRequest(pURLString: "https://mtest.suhyup-bank.com:9190/ib20/act/FIL19826", pDicBody: nil) { bSuccess, errorMsg, resultCommon, resultBody in
            if(bSuccess) {
                do {
                    let common = try JSONDecoder().decode(SUHYUP_COMMON.self, from: resultCommon!)
                    print("common : \(common.desc())" )
//
                    let body = try JSONDecoder().decode(BODY_GOODSDATA.self, from: resultBody!)
                    
                    self.goodsData_VM = BODY_GOODSDATA_VM(goodsData: body)
                    print(" number section : \(self.goodsData_VM.numberOfRowsInSectionDW())")
                    print(" number section : \(self.goodsData_VM.arrDW)")
//                    print(" number section : \(self.goodsData_VM.getGoodsList(BODY_GOODSDATA_VM.GoodsData_GoodsIndex.dw))")
                    print(" number section : \(self.goodsData_VM.getGoodsList(BODY_GOODSDATA_VM.GoodsData_GoodsIndex.dw).count)")
//                      print("body : \(body.desc())" )
                    
                }catch {
                    print("json error", error.localizedDescription)
                }
                
            }else {
                let alertVC = UIAlertController.init(title: "알림", message: errorMsg, preferredStyle: UIAlertController.Style.alert)
                let btnOK = UIAlertAction.init(title: "확인", style: UIAlertAction.Style.default) { action in
                }
                
                alertVC.addAction(btnOK)
                
                self.present(alertVC, animated: true, completion: {
                    
                })
                
            }
        }
    }
    
}
