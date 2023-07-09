//
//  MicoRecordViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2021/03/15.
//  Copyright © 2021 garajilpung. All rights reserved.
//

import UIKit
import AVKit


@objc(MicoRecordViewController)
class MicoRecordViewController: BasicViewController {

    var audioFormat : AVAudioFormat?
    var audioEngine : AVAudioEngine?
    
    
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

    func recorder() {
        let settings : Dictionary = ["AVSampleRateKey" : 44100.0,
            "AVNumberOfChannelsKey" : 1,
            "AVFormatIDKey" : 1819304813,
            "AVLinearPCMIsNonInterleaved" : 0,
            "AVLinearPCMIsBigEndianKey" : 0,
            "AVLinearPCMBitDepthKey" : 16,
            "AVLinearPCMIsFloatKey" : 0]

        audioFormat = AVAudioFormat.init(settings: settings)

        audioEngine = AVAudioEngine.init()
        audioEngine?.inputNode.installTap(onBus: 0, bufferSize: 4410, format: audioEngine?.inputNode.outputFormat(forBus: 0), block: {buffer, when in
            let audioBuffer = buffer.audioBufferList.pointee.mBuffers
            let data : Data = Data.init(bytes: audioBuffer.mData!, count: Int(audioBuffer.mDataByteSize))
            let arraySize = Int(buffer.frameLength)
            let samples = Array(UnsafeBufferPointer(start: buffer.floatChannelData![0], count:arraySize))
//            self.streamData(data: data, len: 4410)
        })

        // Start audio engine
        self.audioEngine?.prepare()
        do {
            try self.audioEngine?.start()
        }
        catch {
            NSLog("cannot start audio engine")
        }
        if(self.audioEngine?.isRunning == true){
            NSLog("Audioengine is running")
        }
    }
}
