//
//  playStoryLyrics.swift
//  Story
//
//  Created by Aries Dwi Prasetiyo on 15/06/20.
//  Copyright © 2020 Aries Dwi Prasetiyo. All rights reserved.
//

import UIKit
import Foundation
import Speech

class playStoryLyrics: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, SFSpeechRecognizerDelegate {
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
         
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
     
    private var recognitionTask: SFSpeechRecognitionTask?
     
    private let audioEngine = AVAudioEngine()
      
    @IBOutlet var Coll: UICollectionView!
    @IBOutlet weak var showTextLabel: UILabel!
    @IBOutlet weak var btnRecord: UIButton!
    @IBOutlet var pointsLabel: UILabel!
    
    var aryData = ["You wake in the morning and roll out of bed","Making your way to the bathroom you take a look in the mirror","Your reflection stares back at you","After you finish showering you dry yourself and return to your bedroom","While you are getting dressed something disturbs you", "You hear a strange noise coming from the bathroom. Glancing across the hallway, you can just make out a dark silhouette in the bathroom doorway", "You barge into the bathroom but it is empty. The air is still heavy with condensation", "For a split second, you notice something in the corner of your vision", "A shadowy figure just slipped out the door", "You rub the fog off the mirror and stare into it but there’s nothing staring back","","","","",""]
    
    var scrollingtimer = Timer()
    
    var currentArrCount = 0
    var currentCount = 0
    var currentArr:Array<Substring> = []
    var currentText = ""
    var points = 0
    
    override func viewDidLoad() {
        self.currentArr = self.aryData[self.currentArrCount].split(separator:" ")
        print(self.currentArr)
        let attribute = NSMutableAttributedString.init(string: String(self.aryData[self.currentArrCount]))
        self.showTextLabel.attributedText = NSMutableAttributedString.init(string: String(self.aryData[self.currentArrCount]))
        super.viewDidLoad()
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return aryData.count
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "playtopiccell", for: indexPath) as? playTopicCell else {
            // we failed to get a PersonCell – bail out!
            fatalError("Unable to dequeue PersonCell.")
        }
        
        let rowIndex = indexPath.row
//        let numberOfrecords:Int = self.aryData.count - 1
//        if (rowIndex < numberOfrecords){
//            rowIndex = (rowIndex + 1)
//        }else {
//            rowIndex = 0
//        }
        
        cell.displayLabel.text = self.aryData[rowIndex]
        
//        scrollingtimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(playStoryLyrics.scrollToView(theTimer:)), userInfo: rowIndex, repeats: true)
      
//        cell.displayLabel.text = "asdajhgjhadbfhjkabdsa"
        // Configure the cell
    
        return cell
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
               recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) {
                result, error in
                    var isFinal = false
                
                if let result = result {
                    if(self.currentArr.count > 1){
                        //tambahin poin disini kalo lo mau per kata
                        let lastArr = result.bestTranscription.formattedString.split(separator: " ").count - 1
                        let lastText = result.bestTranscription.segments[lastArr].substring
                        let lastTarget = self.currentArr[0]
    //                    print(lastText == lastTarget)
                        isFinal = result.isFinal
                

//                        if(lastText.lowercased() == lastTarget.lowercased()){
                        self.points += 5
                        self.pointsLabel.text = String(self.points)
                            self.currentText = self.currentText + " " + self.currentArr[0]
    //                        let range = (self.allText as NSString).range(of: self.currentText)
                            self.currentCount = self.currentText.count
                            let range = NSMakeRange(0, self.currentCount - 1)
                           
                            let attribute = NSMutableAttributedString.init(string: String(self.aryData[self.currentArrCount]))
                            attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue , range: range)
                            self.showTextLabel.attributedText = attribute
                            self.currentArr.remove(at: 0)
//                        }
                       }
                    else if(self.currentArr.count <= 1){
                        //tambahin poin disini kalo lo mau per item column
                        self.currentCount = 1
                        self.currentText = ""
                        self.currentArrCount += 1
                        self.currentArr = self.aryData[self.currentArrCount].split(separator:" ")
                        let range = NSMakeRange(0, self.currentCount - 1)
                        
                        let attribute = NSMutableAttributedString.init(string: String(self.aryData[self.currentArrCount]))
                        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red , range: range)
                        print(attribute)
                        print("render baru")
                        self.showTextLabel.attributedText = attribute
                        self.scrollToView()
                        
                    }
                       else if error != nil || isFinal {
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
                    print("stop")
                   audioEngine.stop()
                   recognitionRequest?.endAudio()
                   self.currentArrCount = 0
                   self.currentCount = 0
                   self.currentText = self.aryData[currentArrCount]
                   btnRecord.isEnabled = true
                   btnRecord.setTitle("Start Recording", for: [])
               } else {
                   try! startRecording()
                   btnRecord.setTitle("Stop recording", for: [])
               }
           }
    
    @objc func scrollToView(){
        if let colls = self.Coll {
            for cell in colls.visibleCells{
                let indexPath: IndexPath? = colls.indexPath(for: cell)
                if (indexPath!.row == self.currentArrCount) {
                    let indexPath1: IndexPath?
                    
                    indexPath1 = IndexPath.init(row:(indexPath?.row)! , section: 0 )

                    colls.scrollToItem(at: indexPath1!, at: .top, animated: true)
                }
            }
        }
//        self.Coll.scrollRectToVisible(CGRect, animated: <#T##Bool#>)
//        self.Coll.scrollToItem(at: IndexPath(row: 1, section: 0), at: .centeredHorizontally, animated: true)
          
//        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseOut, animations: {
//
//        }, completion: nil)
//        self.Coll.setContentOffset(contentOffset: CGPoint,
//        animated animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

            var widthLayout = view.frame.width-60
            var heightLayout = CGFloat(80)
                   
    //        print(widthLayout)
    //        if indexPath.row == a {
    //            isiFloat = 200
    //            heightLayout = CGFloat(isiFloat)
    //        } else {
    //
    //        }

            return CGSize(width: widthLayout, height: heightLayout)
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return 10
       }


}

extension UICollectionView {
    func scrollToNextItem() {
        let contentOffset = CGFloat(floor(self.contentOffset.x + self.bounds.size.height))
        self.moveToFrame(contentOffset: contentOffset)
    }

    func scrollToPreviousItem() {
        let contentOffset = CGFloat(floor(self.contentOffset.x - self.bounds.size.height))
        self.moveToFrame(contentOffset: contentOffset)
    }

    func moveToFrame(contentOffset : CGFloat) {
        self.setContentOffset(CGPoint(x: contentOffset, y: self.contentOffset.y), animated: true)
    }
}
