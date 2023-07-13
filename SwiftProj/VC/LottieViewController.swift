//
//  LottieViewController.swift
//  SwiftProj
//
//  Created by SMG on 2022/07/04.
//  Copyright © 2022 garajilpung. All rights reserved.
//

import UIKit
import Lottie

@objc(LottieViewController)
class LottieViewController: BasicViewController {

    @IBOutlet weak var aniView2: AnimationView!
    private var aniView: AnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        aniView = .init(name: "lottie-nft")
          
        aniView!.frame = view.bounds
          
          // 3. Set animation content mode
          
        aniView!.contentMode = .scaleAspectFit
          
          // 4. Set animation loop mode
          
        aniView!.loopMode = .loop
          
          // 5. Adjust animation speed
          
        aniView!.animationSpeed = 0.5
          
          // 6. Play animation
          
        view.addSubview(aniView!)
        view.sendSubviewToBack(aniView!)
        
        aniView!.play()
        
        
        
        // 1. Set animation content mode
          
        aniView2.contentMode = .scaleAspectFit
          
          // 2. Set animation loop mode
          
        aniView2.loopMode = .loop
          
          // 3. Adjust animation speed
          
        aniView2.animationSpeed = 0.5
          
          // 4. Play animation
        aniView2.play()
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
