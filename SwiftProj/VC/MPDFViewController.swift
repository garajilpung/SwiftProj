//
//  MPDFViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2022/01/03.
//  Copyright © 2022 garajilpung. All rights reserved.
//

import UIKit

@objc(MPDFViewController)
class MPDFViewController: UIViewController {

    private let dicArr = [["url":"a.pdf","title":"titleA"],["url":"b.pdf","title":"titleB"],["url":"c.pdf","title":"titleC"],["url":"D.pdf","title":"titleD"]]
    
    
    @IBOutlet weak var vPro2: UIProgressView!
    @IBOutlet weak var vPro1: UIProgressView!
        
    
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

}
