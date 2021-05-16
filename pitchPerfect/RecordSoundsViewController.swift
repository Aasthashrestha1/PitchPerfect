//
//  RecordSoundsViewController.swift
//  pitchPerfect
//
//  Created by Aastha Shrestha on 5/6/21.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    var audioRecorder: AVAudioRecorder!

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        print("viewWillAppear called")
    }

//    @IBAction func recordAudio(_ sender: Any) {
//            recordingLabel.text = "Recording in Progress"
//            stopRecordingButton.isEnabled = true
//            recordButton.isEnabled = false
    
    
    func configueUI(_ isRecording: Bool) {
        stopRecordingButton.isEnabled = isRecording
        recordButton.isEnabled = !isRecording
        recordingLabel.text = isRecording ? "Recording ..." : "Tap To Record"
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))

        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)

        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        func configueUI(_ Audio: Bool){
            audioRecorder.delegate = self
            audioRecorder.isMeteringEnabled = Audio
            audioRecorder.prepareToRecord(); audioRecorder.record()
            
        }
       // audioRecorder.delegate = self
//        audioRecorder.isMeteringEnabled = true
//        audioRecorder.prepareToRecord()
//        audioRecorder.record()
        
    
//    @IBAction func stopRecording(_ sender: Any) {
//        recordButton.isEnabled = true
//        stopRecordingButton.isEnabled = false
//        recordingLabel.text = "Tap to record"

        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    //Mark: - Audio Recorder Delegate
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool){
        if flag{
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else{
            print("recording was not successful")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender:Any?){
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
    
    
    }



