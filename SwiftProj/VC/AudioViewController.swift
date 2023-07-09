//
//  AudioViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2021/02/25.
//  Copyright © 2021 garajilpung. All rights reserved.
//

import UIKit
import AVFoundation

@objc(AudioViewController)
class AudioViewController: BasicViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {

    var audioPlayer : AVAudioPlayer! // audioPlayer : AVAudioPlayer 인스턴스 변수
    var audioFile : URL! // 재생할 오디오의 파일명 변수
    let MAX_VOLUME : Float = 10.0 // 최대 볼륨, 실수형 상수
    var progressTimer : Timer! // 타이머를 위한 변수
    
    let timePlayerSelector:Selector = #selector(AudioViewController.updatePlayTime)
    let timeRecordSelector:Selector = #selector(AudioViewController.updateRecordTime)
    
    
    
    private var mQudioEngine : AVAudioEngine?
    
    @IBOutlet weak var pvProgressPlay: UIProgressView!
    @IBOutlet weak var lblCurrentTime: UILabel!
    @IBOutlet weak var lblEndTime: UILabel!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var btnPause: UIButton!
    @IBOutlet weak var btnStop: UIButton!
    @IBOutlet weak var slVolume: UISlider!
    @IBOutlet var btnRecord: UIButton!
    @IBOutlet var lblRecordTime: UILabel!
    
    var audioRecorder : AVAudioRecorder!
    var isRecordMode = false // '녹음 모드'를 나타내는 변수. 기본값은 false('재생 모드')
    
    // AVCatpure Audio
    var captureSession: AVCaptureSession?
    let settings = [
        AVFormatIDKey: kAudioFormatMPEG4AAC,
        AVNumberOfChannelsKey : 1,
        AVSampleRateKey : 44100]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mQudioEngine = AVAudioEngine()
        guard let engine = mQudioEngine else {
            return
        }
        
        print(" engine.sampleRate :\(engine.inputNode.inputFormat(forBus: 0).sampleRate)")
        engine.inputNode.removeTap(onBus: 0)
        
        
        // Do any additional setup after loading the view.
        selectAudioFile()
        if !isRecordMode { // 재생 모드일 때(녹음 모드가 아니라면)
            initplay()
            btnRecord.isEnabled = false
            lblRecordTime.isEnabled = false
        } else { // 녹음 모드일 때
            initRecord()
        }
        
        initCapture();
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // 재생 모드와 녹음 모드에 따라 다른 파일을 선택함
    func selectAudioFile(){
        if !isRecordMode { // 재생 모드일 때
             audioFile = Bundle.main.url(forResource: "Kalimba", withExtension: "mp3")
        } else { // 녹음 모드일 때
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            audioFile = documentDirectory.appendingPathComponent("recordFile.m4a")
        }
    }
    
    // 녹음 모드의 초기화
    func initRecord(){
        let recordSettings = [AVFormatIDKey : NSNumber(value: kAudioFormatAppleLossless as UInt32),
                              AVEncoderAudioQualityKey : AVAudioQuality.max.rawValue,
                              AVEncoderBitRateKey : 320000,
                              AVNumberOfChannelsKey : 2,
                              AVSampleRateKey : 44100.0 ] as [String : Any]
        do {
            audioRecorder = try AVAudioRecorder(url: audioFile, settings: recordSettings)
        } catch let error as NSError {
            print("Error-initRecord : \(error)")
        }
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled =  true
        audioRecorder.prepareToRecord()
        
        slVolume.value = 1.0
        audioPlayer.volume = slVolume.value
        lblEndTime.text = convertNSTimeInterval12String(0)
        lblCurrentTime.text = convertNSTimeInterval12String(0)
        setPlayButtons(false, pause: false, stop: false)
        
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSession.Category.playAndRecord)
            
            print(" sampleRate :\(session.sampleRate)")
            
            // 여긴 테스트가 필요는 한데 기기마다 최소 sampleRate가 다른 것 같음(아이폰6s+ 에서 16000이하로는 안됨)
            // API 문서 8000 ~ 44100 사이로 된다고 되어 있음
            try session.setPreferredSampleRate(2000)
            print(" sampleRate Change :\(session.sampleRate)")
            
            
            guard let engine = mQudioEngine else {
                return
            }
            print(" engine.sampleRate2 :\(engine.inputNode.inputFormat(forBus: 0).sampleRate)")
            
        } catch let error as NSError {
            print(" Error-setCategory : \(error)")
        }
        do {
            try session.setActive(true)
        } catch let error as NSError {
            print(" Error-setActive : \(error)")
        }
    }
    
    // 재생 모드의 초기화
    func initplay(){
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFile)
        } catch let error as NSError {
            print("Error-initPlay : \(error)")
        }
        slVolume.maximumValue = MAX_VOLUME // 슬라이더(slVolume) 최대 볼륨 10.0으로 초기화
        slVolume.value = 1.0 // 슬라이더(slVolume) 볼륨 1.0으로 초기화
        pvProgressPlay.progress = 0 // 프로그레스 뷰(pvProgressPlay)의 진행 0으로 초기화
        
        audioPlayer.delegate = self // audioPlayer의 델리게이트는 self
        audioPlayer.prepareToPlay() // prepareToPlay() 실행
        audioPlayer.volume = slVolume.value // audioaplayer 볼륨을 슬라이더(slVolume) 값 1.0으로 초기화
        lblEndTime.text = convertNSTimeInterval12String(audioPlayer.duration)
        lblCurrentTime.text = convertNSTimeInterval12String(0)
        setPlayButtons(true, pause: false, stop: false)
    }
    
    // '재생', '일시 정지', '정지' 버튼을 활성화 또는 비활성화하는 함수
    func setPlayButtons(_ play: Bool, pause: Bool, stop: Bool){
        btnPlay.isEnabled = play
        btnPause.isEnabled = pause
        btnStop.isEnabled = stop
    }
    
    // 00:00 형태의 문자열로 변환함
    func convertNSTimeInterval12String(_ time:TimeInterval) -> String {
        let min = Int(time/60)
        let sec = Int(time.truncatingRemainder(dividingBy: 60))
        let strTime = String(format: "%02d:%02d", min, sec)
        return strTime
    }

    func initCapture() ->Void {
        
    }

    
    // MARK: - AVAudioPlayerDelegate
    
    // 재생이 종료되었을 때 호출함
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        progressTimer.invalidate() // 타이머 무효화
        setPlayButtons(true, pause: false, stop: false)
    }
    
    // '재생' 버튼을 클릭하였을 때
    @IBAction func btnPlayAudio(_ sender: UIButton) {
        audioPlayer.play()
        setPlayButtons(false, pause: true, stop: true)
        progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timePlayerSelector, userInfo: nil, repeats: true)
    }
    
    // MARK: - UIEvent
    
    // '일시 정지' 버튼을 클릭하였을 때
    @IBAction func btnPauseAudio(_ sender: UIButton) {
        audioPlayer.pause()
        setPlayButtons(true, pause: false, stop: true)
    }
    
    // '정지' 버튼을 클릭하였을 때
    @IBAction func btnStopAudio(_ sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        lblCurrentTime.text = convertNSTimeInterval12String(0)
        setPlayButtons(true, pause: false, stop: false)
        progressTimer.invalidate() // 타이머 무효화
    }
    
    // 볼륨 슬라이더 값을 audioplayer.volume에 대임함
    @IBAction func slChangeVolume(_ sender: UISlider) {
        audioPlayer.volume = slVolume.value
    }
    // 스위치를 ON/Off하여 녹음모드 인지 재생 모드인지를 결정함
    @IBAction func swRecordMode(_ sender: UISwitch) {
        if sender.isOn { // 녹음 모드일 때
            audioPlayer.stop()
            audioPlayer.currentTime = 0
            lblRecordTime!.text = convertNSTimeInterval12String(0)
            isRecordMode = true
            btnRecord.isEnabled = true
            lblRecordTime.isEnabled = true
        } else { // 재생 모드일 때
            isRecordMode = false
            btnRecord.isEnabled = false
            lblRecordTime.isEnabled = false
            lblRecordTime.text = convertNSTimeInterval12String(0)
        }
        selectAudioFile() // 모드에 따라 오디오 파일을 선택함
        
        // 모드에 따라 재생 초기화 또는 녹음 초기화를 수행함
        if !isRecordMode { // 녹음 모드가 아닐 때, 즉 재생 모드일 때
            initplay()
        } else { // 녹음 모드일 때
            initRecord()
        }
    }
    
    @IBAction func btnRecord(_ sender: UIButton) {
        if sender.titleLabel?.text == "Record" { // 버튼이 'Record'일 때 녹음을 중지함
            audioRecorder.record()
            sender.setTitle("Stop", for: UIControl.State())
            progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timeRecordSelector, userInfo: nil, repeats: true)
        } else { // 버튼이 'Stop'일 때 녹음을 위한 초기화를 수행함
            audioRecorder.stop()
            progressTimer.invalidate() // 녹음이 중지되면 무효화
            sender.setTitle("Record", for: UIControl.State())
            btnPlay.isEnabled = true
            initplay()
        }
    }
    
    // MARK: - Timer
    // 0.1초마다 호출되며 재생 시간을 표시함
    @objc func updatePlayTime(){
        lblCurrentTime.text = convertNSTimeInterval12String(audioPlayer.currentTime) // 재생 시간인 audioPlayer.currentTime을 lblCurrentTime에 나타냄
        pvProgressPlay.progress = Float(audioPlayer.currentTime/audioPlayer.duration) // 프로그레스(Progress View)인 pvProgressPlay의 진행 상황에 audioPlayer.currentTime을 audioPlayer.duration으로 나눈 값으로 표시
    }
    
    // 0.1초마다 호출되며 녹음 시간을 표시함
    @objc func updateRecordTime(){
        lblRecordTime.text = convertNSTimeInterval12String(audioRecorder.currentTime)
    }
    
    // MARK: - AVAudioRecorderDelegate
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("종료")
    }
    
    
    // MARK: - AVCaptureSession 중 audio
    
}
