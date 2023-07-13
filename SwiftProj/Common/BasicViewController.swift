//
//  BasicViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2020/11/23.
//  Copyright © 2020 garajilpung. All rights reserved.
//

import UIKit

class BasicViewController: UIViewController {

    var m_nMainType : Int = 0
    var m_nSubType : Int = 0
    
    // 아래의 세가지 값은 viewDidAppear 호출된 이후에 설정된다.
    private var nNochiTop : CGFloat = 0 // 순수 노치 top 영역
    private var nNochiBottom : CGFloat = 0 // 순수 노치 bottom 영역
    private var nViewTop : CGFloat = 0  // viewController 에서 실제 상단 높이
    private var nViewRealHeight : CGFloat = 0 // 실제 뷰가 그려질 수 있는 영역
    private var bNavigationBar : Bool = false // navigationbar가 포함되는지 안되는지
    private let nNavigationBarHeight : CGFloat = 44.0 // 현재 로써는 강제 고정 값이다.
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navibar = self.navigationController {
            if !(navibar.isNavigationBarHidden) {
                bNavigationBar = true
            }
        }
        
        // Do any additional setup after loading the view.
        setInit()
        setView()
        setKVO()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        addNoti()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        nNochiTop = self.view.safeAreaInsets.top - (bNavigationBar ? nNavigationBarHeight : 0.0)
        nNochiBottom = self.view.safeAreaInsets.bottom
        nViewTop = self.view.safeAreaInsets.top
        nViewRealHeight = self.view.frame.height - (self.view.safeAreaInsets.top + self.view.safeAreaInsets.bottom)
        
        DFT_TRACE_PRINT(output: "Nochi 상단 \(nNochiTop), Nochi 하단 \(nNochiBottom), RealHeight \(nViewRealHeight)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeNoti()
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - Basic UserMethod
    func setInit() {
        print("setInit")
        
        
    }
    
    func setView() {
        print("setView")
        setLocale()
        
    }
 
    func setLocale() {
        print("setLocale")
    }
    
    func setKVO() {
        print("setKVO")
    }
    
    func addNoti() {
        print("addNoti")
    }
    
    func removeNoti(){
        print("removeNoti")
    }
    
}
