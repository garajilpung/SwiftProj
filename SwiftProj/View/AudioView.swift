//
//  AudioView.swift
//  SwiftProj
//
//  Created by suhyup02 on 2022/03/17.
//  Copyright © 2022 garajilpung. All rights reserved.
//

import UIKit
import AVFoundation

class AudioView: UIView {
    
    private var _audioURL : String = ""
    public var audioURL : String {
        get {
            return _audioURL
        }
        
        set {
            _audioURL = newValue
            
            audioItem = AVPlayerItem(url: URL.init(string: _audioURL)!)
            audioItem?.addObserver(self, forKeyPath: #keyPath(AVPlayerItem.status), options: [.new], context: nil)
            
            
            audioPlayer = AVPlayer(playerItem: audioItem)
        }
    }
    
    private var _audioTitle : String = "default"
    public var audioTitle : String {
        get {
            return _audioTitle
        }
        set {
            self.lbTitle.text = newValue
            _audioTitle = newValue
        }
    }
        
    private var audioPlayer : AVPlayer?
    private var audioItem : AVPlayerItem?
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var sdTime: UISlider!
    
    required init() {
        super.init(frame: CGRect.zero)
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        
        setInit()
        setView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setInit()
        setView()
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func setInit()-> Void{
        
    }
    
    func setView()->Void {
        let  v : UIView = Bundle.main.loadNibNamed("AudioView", owner: self, options: nil)?[0] as! UIView
        v.frame = self.bounds;
        
        self.addSubview(v);
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
    
    // MARK: - Slider Event
    @IBAction func onSliderTimeChanged(_ sender: UISlider) {
        let seconds : Int64 = Int64(sender.value)
        let targetTime : CMTime = CMTimeMake(value: seconds, timescale: 1)
        
        audioPlayer?.seek(to: targetTime)
        
        if audioPlayer?.rate == 0
        {
            audioPlayer?.play()
        }
    }
    
    
    // MARK: - Button Event
    @IBAction func onBtnPre(_ sender: Any) {
        
    }
    
    @IBAction func onBtnPause(_ sender: Any) {
        audioPlayer?.pause()
    }
    
    @IBAction func onBtnPlay(_ sender: Any) {
        audioPlayer?.play()
    }
    
    @IBAction func onBtnStop(_ sender: Any) {
        audioPlayer?.pause()
        audioPlayer?.seek(to: CMTimeMake(value: 0, timescale: 1))
    }
    
    @IBAction func onBtnPost(_ sender: Any) {
        
    }
    
}
