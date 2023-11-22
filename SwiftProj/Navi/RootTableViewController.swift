//
//  RootTableViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2020/11/23.
//  Copyright © 2020 garajilpung. All rights reserved.
//

import UIKit
import WebKit
//import testFramework

class RootTableViewController: UITableViewController {

    var dicDB : NSDictionary! = NSDictionary.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

        self.title = "Root"
        
        let path : String! = Bundle.main.path(forResource: "dic", ofType: "plist")
        
        dicDB = NSDictionary.init(contentsOfFile: path)
        
        print("시작")
        
        //쿠키 클리어
        if #available(iOS 12.0 , *) {
            WKWebsiteDataStore.default().httpCookieStore.getAllCookies { cookies in
                for cookie in cookies {
                    WKWebsiteDataStore.default().httpCookieStore.delete(cookie) {
                        
                    }
                }
            }
        }else {
            let nSet : NSSet = NSSet.init(array: [WKWebsiteDataTypeCookies])
            let nDate : NSDate = NSDate.init(timeIntervalSince1970: 0)
            WKWebsiteDataStore.default().removeData(ofTypes: nSet as! Set<String>, modifiedSince: nDate as Date) {
                // delete
            }
        }
        
        
        //cache 삭제
        let nSet2 : NSSet = NSSet.init(array: [WKWebsiteDataTypeDiskCache, WKWebsiteDataTypeMemoryCache])
        let nDate2 : NSDate = NSDate.init(timeIntervalSince1970: 0)
        WKWebsiteDataStore.default().removeData(ofTypes: nSet2 as! Set<String>, modifiedSince: nDate2 as Date) {
            // delete
        }
        
        
        /// cookie
//        GlobalData.sharedInstance.getCookie(type: 0)
//        print("cookie \(GlobalData.sharedInstance.dataCookie!)")
//        
//        GlobalData.sharedInstance.getCookie(type: 1)
//        print("cookie \(GlobalData.sharedInstance.dataCookie!)")
        
        
        // loading gif
        let view = UIView(frame: CGRect(x: 0, y: 0, width: GlobalData.sharedInstance.screenWidth, height: GlobalData.sharedInstance.screenHeight))
        view.loadLoading()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChange), name: UIDevice.orientationDidChangeNotification , object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        tableView.reloadData()
        
        
        let orientationValue = UIInterfaceOrientationMask.portrait.rawValue
        UIDevice.current.setValue(orientationValue, forKey: "orientation")
        
        
        let qu = DispatchQueue(label: "222vassdf", attributes: DispatchQueue.Attributes.concurrent)
        
        qu.sync {
            for _ in 0...100 {
                print("sync1")
            }
        }
        
        qu.sync {
            for _ in 0...5 {
                print("sync2")
            }
        }
     
        qu.sync {
            for _ in 0...5 {
                print("sync3")
            }
        }
        
        qu.sync {
            for _ in 0...5 {
                print("sync4")
            }
        }
        
        qu.sync {
            for _ in 0...5 {
                print("sync5")
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    

    // MARK: - Shake Event
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        print("루트 모션 시작")
        if motion == .motionShake {
//            lb1.text = "흔들기 모션 중"
//            lb2.text = "흔들기 모션 시작됨"
        }
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
//        lb1.text = "흔들기 모션 종료"
        print("루트 모션 종료")
        if motion == .motionShake {
            print("루트 흔들기 종료")
        }
    }
    
    
    override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
//        lb1.text = "흔들기 모션 취소"
        print("루트 모션 취소")
        if motion == .motionShake {
            print("루트 흔들기 취소")
        }
    }
    
    // MARK: - ViewController delegate
      open override var shouldAutorotate: Bool {
         return false
     }
     
     open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
         return .portrait
     }
     
     open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
         return .portrait
     }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return dicDB.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var count :Int = 0
        var temp : Array = Array<Any>.init()
        
        switch section {
        case 0:
            temp = dicDB.object(forKey: "section1") as! [Any]
            break
        case 1:
            temp = dicDB.object(forKey: "section2") as! [Any]
            break
        default:
            temp = dicDB.object(forKey: "section3") as! [Any]
            break
        }
        
        count = temp.count
        
        return count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 20.0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView : UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: GlobalData.sharedInstance.screenWidth , height: 20))

        sectionView.backgroundColor = (UIColor.init(red: 0.306, green: 0.161, blue: 0.047, alpha: 1.0)).withAlphaComponent(0.9)
        let headerLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: GlobalData.sharedInstance.screenWidth , height: 20))
        
        headerLabel.backgroundColor = UIColor.red
        headerLabel.isOpaque = false
        headerLabel.textColor = UIColor.white
        headerLabel.highlightedTextColor = UIColor.white
        
        switch section {
        case 1:
            headerLabel.text = "section2"
        case 2:
            headerLabel.text = "section3"
        default: // 0도 포함
            headerLabel.text = "section1"
        }
        
        sectionView.addSubview(headerLabel)
        return sectionView
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.0
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let sectionView : UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: GlobalData.sharedInstance.screenWidth , height: 20))

        sectionView.backgroundColor = UIColor.init(red: 0.306, green: 0.161, blue: 0.047, alpha: 0.9)
        let headerLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: GlobalData.sharedInstance.screenWidth , height: 20))
        
        headerLabel.backgroundColor = UIColor.red
        headerLabel.isOpaque = false
        headerLabel.textColor = UIColor.white
        headerLabel.highlightedTextColor = UIColor.white
        headerLabel.text = "text"
        
        sectionView.addSubview(headerLabel)
        return sectionView
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35.0
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "vcCellTitle", for: indexPath)

        // Configure the cell...

        var arr : Array = Array<Any>.init()
        var header : NSDictionary = NSDictionary.init()
        
        switch indexPath.section {
        case 1:
            arr = dicDB.object(forKey: "section2") as! [Any]
        case 2:
            arr = dicDB.object(forKey: "section3") as! [Any]
        default:
            arr = dicDB.object(forKey: "section1") as! [Any]
        }
        
        header = arr[indexPath.row] as! NSDictionary
                
        cell.textLabel!.text =  header["title"] as? String
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        var actID : String = ""
        
        var actType :String = ""
        var target : String = ""
        var strClassName : String = ""
        
        var temp : Array = Array<NSDictionary>.init()
        var dic : NSDictionary = NSDictionary.init()
        
        switch indexPath.section {
        case 1:
            temp = dicDB.object(forKey: "section2") as! [NSDictionary]
        case 2:
            temp = dicDB.object(forKey: "section3") as! [NSDictionary]
        default:
            temp = dicDB.object(forKey: "section1") as! [NSDictionary]
        }
        
        dic = temp[indexPath.row]
        
        actType = dic["actType"] as! String
        target = dic["target"] as! String
        strClassName = dic["actID"] as! String
        
        if(strClassName.elementsEqual("none")) {
            let alertVC = UIAlertController.init(title: "알림", message: "구현할 필요가 없는 부분", preferredStyle: UIAlertController.Style.alert)
            let btnOK = UIAlertAction.init(title: "확인", style: UIAlertAction.Style.default) { action in
                alertVC.dismiss(animated: true) {
                    
                }
            }
            
            alertVC.addAction(btnOK)
            
            self.present(alertVC, animated: true, completion: {
                
            })
        }else {
            if(target.elementsEqual("none")) {
                
            }else if(target.elementsEqual("Object")) {
                // 클래스 이름에서 클래스를 생성해서 호출하는 방법
                let aClass = NSClassFromString(strClassName) as! UIViewController.Type
                let viewController = aClass.init()
                viewController.title = dic["title"] as? String
                self.navigationController?.pushViewController(viewController, animated: true)
            }else if(target.elementsEqual("Main")) {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: strClassName)
                self.navigationController?.pushViewController(vc!, animated: true)
                
            }else if(target.elementsEqual("Main2")) {
//                let storyboard = UIStoryboard(name: "Main2", bundle: nil)
//                let vc = storyboard.instantiateViewController(withIdentifier: strClassName)
//                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            
            
        }
        
//        let vc = Bundle.main.loadNibNamed(strClassName, owner: self, options: nil)?.first as! UIViewController
//        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - Button Event
    
    @IBAction func onBtnSetting(_ sender: UIButton) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "settingVC")
        
        self.present(vc, animated: true) {
            
        }
    }
    
    
    
    @objc func deviceOrientationDidChange() {
        let frame = self.view.frame
        
        DFT_TRACE_PRINT(output: "\(frame.size.width)][ \(frame.size.height)")
        
    }
}
