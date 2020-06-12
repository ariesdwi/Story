//
//  playTopic.swift
//  Story
//
//  Created by Aries Dwi Prasetiyo on 12/06/20.
//  Copyright © 2020 Aries Dwi Prasetiyo. All rights reserved.
//

import UIKit



class playTopic: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    
    
    let layout = UICollectionViewFlowLayout()
//    @IBOutlet var Collect: UICollectionView!
//
    var scrollingtimer = Timer()
//
//    var textTopic:[String] = ["This is especially true in the nonprofit and social impact world. We tell stories to amplify awareness","We tell stories to raise money – to do the good we want to do. And when we’ve done that good, ","we tell stories about it so donors ","volunteers, and supporters can participate in the good their gifts make possible. We tell stories to invite others in. "]
//
    override func viewDidLoad() {
        super.viewDidLoad()
        layout.scrollDirection = .vertical
       
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "playtopiccell", for: indexPath) as? playTopicCell else {
                    // we failed to get a PersonCell – bail out!
                    fatalError("Unable to dequeue PersonCell.")
                }
        
        cell.backgroundColor = .red
        
        
        var rowIndex = indexPath.row
        let numberOfrecords:Int = 9
        if (rowIndex < numberOfrecords){
            rowIndex = (rowIndex + 1)
        }else {
            rowIndex = 0
        }
        scrollingtimer =  Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector (playTopic.startTimer(theTimer:)), userInfo: rowIndex, repeats: true)
        return cell
    }
    
    @objc func startTimer(theTimer:Timer){
        UIView.animate(withDuration: 6.0, delay: 0, options: .curveEaseOut, animations: {
            
            self.collectionView.scrollToItem(at: IndexPath(row: theTimer.userInfo! as! Int, section: 0), at: .centeredVertically, animated: false)
            
        },completion: nil)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width-60, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
    
    
//
//    func scrollToNextCell(){
//
//        //get cell size
//        let cellSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
//
//        //get current content Offset of the Collection view
//        let contentOffset = collectionView.contentOffset
//
//        //scroll to next cell
//        collectionView.scrollRectToVisible(CGRect(x: contentOffset.x + cellSize.width, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true)
//
//
//    }
//
//    /**
//     Invokes Timer to start Automatic Animation with repeat enabled
//     */
//    func startTimer() {
//        scrollingtimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: Selector("scrollToNextCell"), userInfo: nil, repeats: true);
//
//    }

}

    

//
//extension playTopic: UICollectionViewDelegate, UICollectionViewDataSource{
//
//
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return textTopic.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "playtopiccell", for: indexPath) as? playTopicCell else {
//            // we failed to get a PersonCell – bail out!
//            fatalError("Unable to dequeue PersonCell.")
//        }
//
//        cell.lyricsLabel.text = textTopic[indexPath.row]
//
//        var rowIndex = indexPath.row
//        let numberOfrecords:Int = self.textTopic.count - 1
//        if (rowIndex < numberOfrecords){
//            rowIndex = (rowIndex + 1)
//        }else {
//            rowIndex = 0
//        }
//
//        scrollingtimer =  Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector (playTopic.startTimer(theTimer:)), userInfo: rowIndex, repeats: true)
//
//        // if we're still here it means we got a PersonCell, so we can return it
//        return cell
//    }
//
//    @objc func startTimer(theTimer:Timer){
//        UIView.animate(withDuration: 6.0, delay: 0, options: .curveEaseOut, animations: {
//
//            self.Collect.scrollToItem(at: IndexPath(row: theTimer.userInfo! as! Int, section: 0), at: .centeredVertically, animated: false)
//
//        },completion: nil)
//    }
//
//
//}
