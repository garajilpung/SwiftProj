//
//  ListViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2020/11/27.
//  Copyright © 2020 garajilpung. All rights reserved.
//

import UIKit

@objc(ListViewController)
class ListViewController: BasicViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var m_Table: UITableView!
    
    
    var mArr : Array = Array<Any>.init()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        m_Table.delegate = self
        m_Table.dataSource = self
        
        mArr = ["Aa", "Bb", "Cc", "Dd", "Ee", "Ff", "Gg", "Hh", "Ii", "Jj", "Kk", "Ll", "Mm", "Nn", "Oo", "Pp", "Qq", "Rr", "Ss", "Tt", "Uu", "Vv", "Ww", "Xx", "Yy", "Zz"]
        
        let vh : UIView = UIView.init(frame: CGRect.init(x:0, y:0, width: GlobalData.sharedInstance.screenWidth , height: 50))
        vh.backgroundColor = UIColor.blue
        m_Table.tableHeaderView = vh
        
        let vf : UIView = UIView.init(frame: CGRect.init(x:0, y:0, width: GlobalData.sharedInstance.screenWidth, height: 50))
        vf.backgroundColor = UIColor.blue
        m_Table.tableFooterView = vf
     
        m_Table.register(UINib(nibName: "ListCell", bundle: nil), forCellReuseIdentifier: "tableViewCell")
        m_Table.register(ListCell2.self, forCellReuseIdentifier: "tableViewCell2")
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    // MARK: - UITableView Delegate

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v : UIView = UIView.init(frame: CGRect.init(x:0,  y:0, width:GlobalData.sharedInstance.screenWidth, height:20))
        v.backgroundColor = UIColor.red
        return v
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let v : UIView = UIView.init(frame: CGRect.init(x:0,  y:0, width:GlobalData.sharedInstance.screenWidth, height:20))
        v.backgroundColor = UIColor.yellow
        return v
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell
        
        print("c ccvadf [" , indexPath.section , "]")
        
        switch indexPath.section {
        case 1,2:
            cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell2", for: indexPath) as! ListCell2
            (cell as! ListCell2 ).lbText.text = mArr[indexPath.row] as? String

        default:
            cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! ListCell
            (cell as! ListCell ).lbText.text = mArr[indexPath.row] as? String

        }
        
        return cell
    }
}
