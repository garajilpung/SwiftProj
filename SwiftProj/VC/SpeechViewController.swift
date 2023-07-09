//
//  SpeechViewController.swift
//  SwiftProj
//
//  Created by SMG on 2021/07/13.
//  Copyright © 2021 garajilpung. All rights reserved.
//

import UIKit
import AVKit

@objc(SpeechViewController)
class SpeechViewController: BasicViewController, AVSpeechSynthesizerDelegate {

    var mUtterance : AVSpeechUtterance!
    var mSynthesizer : AVSpeechSynthesizer!
    
    @IBOutlet weak var tvText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print("Speech Voice Start")
        print("\(AVSpeechSynthesisVoice.speechVoices())")
        print("Speech Voice End")
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
    @IBAction func onBtnPlay(_ sender: UIButton) {
        let text : String = tvText.text
        
        mUtterance = AVSpeechUtterance.init(string: text)
        mUtterance.rate = AVSpeechUtteranceDefaultSpeechRate
        mUtterance.voice = AVSpeechSynthesisVoice.init(language: "ko-KR")
        
        mSynthesizer = AVSpeechSynthesizer.init()
        mSynthesizer.delegate = self
        mSynthesizer.speak(mUtterance)
    }
    
    @IBAction func onBtnPause(_ sender: UIButton) {
        guard let synthesizer = mSynthesizer else {
            return
        }
        
        synthesizer.pauseSpeaking(at: .word)
    }
    
    @IBAction func onBtnStop(_ sender: UIButton) {
        guard let synthesizer = mSynthesizer else {
            return
        }
        
        synthesizer.stopSpeaking(at: .word)
    }
    
    @IBAction func onBtnResume(_ sender: UIButton) {
        guard let synthesizer = mSynthesizer else {
            return
        }
        
        synthesizer.continueSpeaking()
    }
    
    // MARK: - AVSpeechSynthesizerDelegate
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        print("speechSynthesizer didStart")
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        print("speechSynthesizer didFinish")
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didPause utterance: AVSpeechUtterance) {
        print("speechSynthesizer didPause")
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didContinue utterance: AVSpeechUtterance) {
        print("speechSynthesizer didContinue")
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        print("speechSynthesizer didCancel")
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        print("speechSynthesizer didStart \(characterRange.location), \(characterRange.length)")
    }
}
