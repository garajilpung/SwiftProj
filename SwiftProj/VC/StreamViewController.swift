//
//  StreamViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2021/06/22.
//  Copyright © 2021 garajilpung. All rights reserved.
//

import UIKit
import AVKit

@objc(StreamViewController)
class StreamViewController: BasicViewController, CustomStreamDeleage {

    @IBOutlet weak var lbText: UILabel!
    @IBOutlet weak var tfInput: UITextField!
        
    
    private var tcp : TcpSocket = TcpSocket()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        do {
//            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
//            try AVAudioSession.sharedInstance().setActive(true)
//        }catch let error {
//            print(error.localizedDescription)
//            return
//        }
//
//        let mp3URL = URL(string: "https://garajilpung.synology.me/test/ss.mp3")
//
//        let asset = AVAsset(url: mp3URL!)
//        let playerItem = AVPlayerItem(asset: asset)
//
//        self.player = AVPlayer(playerItem: playerItem)
//
//
//
////        let playerLayer = AVPlayerLayer(player: player)
////        playerLayer.frame = self.videoView.bounds //bounds of the view in which AVPlayer should be displayed
////        playerLayer.videoGravity = .resizeAspect
        
        
        
        tcp.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        guard let player = self.player else {
//            return
//        }
//        
//        player.play()
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
    @IBAction func onBtnConnect(_ sender: Any) {
        
        tcp.connect(host: "58.140.3.16", port: 8107)
    }
    
    
    @IBAction func onBtnSend(_ sender: Any) {
        
        tcp.send(data: (tfInput.text?.data(using: .utf8))!)
    }
    
    
    func onReceive(state:Int, bSuccess:Bool) {
        if(bSuccess) {
            
        }else {
            print("State :\(state)")
        }
    }
}
