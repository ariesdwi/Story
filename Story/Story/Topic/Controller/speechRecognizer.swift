//
//  ViewController.swift
//  TestSpeechToText
//
//  Created by Grace Cindy on 15/06/20.
//  Copyright © 2020 Grace Cindy. All rights reserved.
//

import UIKit
import Speech

class ViewController: UIViewController, SFSpeechRecognizerDelegate {

    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
       
       private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
       
       private var recognitionTask: SFSpeechRecognitionTask?
       
       private let audioEngine = AVAudioEngine()
    
    var currentCount = 0
    var currentText = ""

    var allText = "Hello my name is Aries"
    var targetText = "Hello my name is Aries".split(separator:" ")
    
    @IBOutlet weak var showTextLabel: UITextField!
    @IBOutlet weak var btnRecord: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    
    override public func viewDidAppear(_ animated: Bool) {
           
           SFSpeechRecognizer.requestAuthorization { authStatus in
               /*
                   The callback may not be called on the main thread. Add an
                   operation to the main queue to update the record button's state.
               */
               OperationQueue.main.addOperation {
                   switch authStatus {
                       case .authorized:
                           self.btnRecord.isEnabled = true
    
                       case .denied:
                           self.btnRecord.isEnabled = false
                           self.btnRecord.setTitle("User denied access to speech recognition", for: .disabled)
    
                       case .restricted:
                           self.btnRecord.isEnabled = false
                           self.btnRecord.setTitle("Speech recognition restricted on this device", for: .disabled)
    
                       case .notDetermined:
                           self.btnRecord.isEnabled = false
                           self.btnRecord.setTitle("Speech recognition not yet authorized", for: .disabled)
                   }
               }
           }
       }
       
       private func startRecording() throws {
    
           // Cancel the previous task if it's running.
           if let recognitionTask = recognitionTask {
               recognitionTask.cancel()
               self.recognitionTask = nil
           }
           
           let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(AVAudioSession.Category.record)
        try audioSession.setMode(AVAudioSession.Mode.measurement)
        //try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        try audioSession.setActive(true, options: .init())
           
           recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
           
            let inputNode = audioEngine.inputNode
           guard let recognitionRequest = recognitionRequest else { fatalError("Unable to created a SFSpeechAudioBufferRecognitionRequest object") }
           
           // Configure request so that results are returned before audio recording is finished
           recognitionRequest.shouldReportPartialResults = true
           
           // A recognition task represents a speech recognition session.
           // We keep a reference to the task so that it can be cancelled.
        // track last word
           recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
                var isFinal = false

            
            if let result = result {
                let lastArr = result.bestTranscription.formattedString.split(separator: " ").count - 1
                if(self.targetText.count > 0){
                    let lastText = result.bestTranscription.segments[lastArr].substring
                    let lastTarget = self.targetText[0]
//                    print(lastText)
//                    print(lastTarget)
//                    print(lastText == lastTarget)
                    isFinal = result.isFinal

                    if(lastText == lastTarget){
                        self.currentText = self.currentText + " " + self.targetText[0]
//                        let range = (self.allText as NSString).range(of: self.currentText)
                        self.currentCount = self.currentText.count
                        let range = NSMakeRange(0, self.currentCount-1)
                       
                        let attribute = NSMutableAttributedString.init(string: self.allText)
                        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red , range: range)
                        print(attribute)
                        print("masuk")
                        self.showTextLabel.attributedText = attribute
                        self.targetText.remove(at: 0)
                    }
                   }
                   
                   if error != nil || isFinal {
                       self.audioEngine.stop()
                       inputNode.removeTap(onBus: 0)
                       
                       self.recognitionRequest = nil
                       self.recognitionTask = nil
                       
                       self.btnRecord.isEnabled = true
                       self.btnRecord.setTitle("Start Recording", for: [])
                   }
                }
                
           }
           
           let recordingFormat = inputNode.outputFormat(forBus: 0)
           inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
               self.recognitionRequest?.append(buffer)
           }
           
           audioEngine.prepare()
           
           try audioEngine.start()
           
        showTextLabel.text = self.allText
       }
    
       // MARK: SFSpeechRecognizerDelegate
       
       public func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
           if available {
               btnRecord.isEnabled = true
               btnRecord.setTitle("Start Recording", for: [])
           } else {
               btnRecord.isEnabled = false
               btnRecord.setTitle("Recognition not available", for: .disabled)
           }
       }
       
       // MARK: Interface Builder actions
       
    
    
    @IBAction func recordButtonTapped(_ sender: UIButton) {
           if audioEngine.isRunning {
               audioEngine.stop()
               recognitionRequest?.endAudio()
               btnRecord.isEnabled = false
               btnRecord.setTitle("Stopping", for: .disabled)
           } else {
               try! startRecording()
               btnRecord.setTitle("Stop recording", for: [])
           }
       }

}

