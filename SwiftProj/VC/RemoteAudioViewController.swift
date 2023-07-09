//
//  RemoteAudioViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2022/03/15.
//  Copyright © 2022 garajilpung. All rights reserved.
//

import UIKit
import AVKit

@objc(RemoteAudioViewController)
class RemoteAudioViewController: BasicViewController {

    
    
    private var arrAudioFile : [AVPlayerItem] = []
    private let arrAudioFileURL : [String] = ["/test/audio/audio_01.wav",
                                              "/test/audio/audio_02.wav",
                                              "/test/audio/audio_03.wav",
                                              "/test/audio/audio_04.wav",
                                              "/test/audio/audio_05.wav",
                                              "/test/audio/audio_06.wav",
                                              "/test/audio/audio_07.wav",
                                              "/test/audio/audio_08.wav",
                                              "/test/audio/audio_09.wav",
                                              "/test/audio/audio_10.wav",
                                              "/test/audio/audio_11.wav",
                                              "/test/audio/audio_12.wav"]
    
    private var avFPlayer : AVPlayer!
    
    
    
    
    private var avPlyaer : AVPlayer = AVPlayer()
    private var audioItem : AVPlayerItem!
    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var MusicView: AudioView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        audioItem.removeObserver(self, forKeyPath: #keyPath(AVPlayerItem.status))
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    // MARK: - 초기화
    override func setInit() {
        super.setInit()
        
//        for el in arrAudioFileURL {
//            let downURLString = String(format: "%@%@", Utility.getHost(), el)
//
//            print("downURLString \(downURLString)")
//            let downURL = URL(string: downURLString)
//
//            let asset = AVAsset(url: downURL!)
//
////            asset.loadValuesAsynchronously(forKeys: ["playable"]) {
////                print("ASSet Load success ");
////            }
//
//            let item = AVPlayerItem(asset: asset, automaticallyLoadedAssetKeys: ["playable"])
//
//            arrAudioFile.append(item)
//        }
        

        self.audioInit()
    }
    
    override func setView() {
        super.setView()
        
        
        
        
        
    }
    
    // MARK: - AVPlayerInit
    private func audioInit() {
        let downURLString = String(format: "%@%@", Utility.getHost(), arrAudioFileURL[0])
        let asset = AVAsset(url: URL(string: downURLString)!)
        audioItem = AVPlayerItem(asset: asset)
        
        audioItem.addObserver(self, forKeyPath: #keyPath(AVPlayerItem.status), options: [.new], context: nil)
        
        
        // AVPlayerItem 자체로는 데이터가 로드가 안된다. AVPlayer에 넣어야만 가능하다.
        // 아래에 따로 관련 처리를 추가했다.
        // AVQueuePlayer 라는 클래스가 있지만 순서대로만 가능핟.
        
        avPlyaer = AVPlayer(playerItem: audioItem!)
        //아래 변수를 false로 하면 딜레이 없이 바로 재생된다. (버퍼가 없기 때문에 끊길 수도 있다.)
//        avPlyaer.automaticallyWaitsToMinimizeStalling = false;
        
        print("duration \(audioItem!.duration )")
    }
    
    // MARK: - KVO
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {

        if keyPath == #keyPath(AVPlayerItem.status) {
            let status : AVPlayerItem.Status
            
            // Get the status change from the change dictionary
            if let statusNumber = change?[.newKey] as? NSNumber {
               status = AVPlayerItem.Status(rawValue: statusNumber.intValue)!
            } else {
               status = .unknown
            }

            // Switch over the status
            switch status {
                case .readyToPlay:
                    // Player item is ready to play.
                    print("readyToPlay")
                    print("duration \(audioItem!.duration )")
                    print("duration Sceond \(CMTimeGetSeconds(audioItem!.duration))")
                    break;
                case .failed:
                    // Player item failed. See error.
                    break;
                case .unknown:
                       // Player item is not yet ready.
                    break;
                @unknown default:
                   fatalError()
                    break;
            }
            
        }
    }
    
    
    // MARK: - Button Event
    @IBAction func onBtnPlay(_ sender: Any) {
        self.avPlyaer.play()
    }
    
    @IBAction func onBtnPause(_ sender: Any) {
        avPlyaer.pause()
    }
    
    @IBAction func onBtnStop(_ sender: Any) {
        avPlyaer.pause()
        avPlyaer.seek(to: .zero)
    }
}
