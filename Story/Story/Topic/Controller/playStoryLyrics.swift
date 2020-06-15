//
//  playStoryLyrics.swift
//  Story
//
//  Created by Aries Dwi Prasetiyo on 15/06/20.
//  Copyright © 2020 Aries Dwi Prasetiyo. All rights reserved.
//

import UIKit

class playStoryLyrics: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet var Coll: UICollectionView!
    var aryData:[String] = ["Story telling merupakan sesuatu yang sudah sangat umum kita dengar.","Story telling merupakan suatu kegiatan atau aktivitas berupa seni dengan menceritakan ulang sebuah cerita yang berbentuk .","legenda ataupun fabel dengan cara yang menarik","Di sekolah story telling biasanya menjadi salah satu kegiatan yang di lombakan, selain dari speech atau pidato bahasa inggris. Bagi sahabat KBI yang masih sekolah dan bingung mencari referensi cerita apa yang cocok untuk story telling, berikut Referensi nya."]
    
    var scrollingtimer = Timer()

    
    override func viewDidLoad() {
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
        
        var rowIndex = indexPath.row
        let numberOfrecords:Int = self.aryData.count - 1
        if (rowIndex < numberOfrecords){
            rowIndex = (rowIndex + 1)
        }else {
            rowIndex = 0
        }
        
        
        scrollingtimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(playStoryLyrics.scrollToView(theTimer:)), userInfo: rowIndex, repeats: true)
        
      
        cell.displayLabel.text = "asdajhgjhadbfhjkabdsa"
        // Configure the cell
    
        return cell
    }
    
    @objc func scrollToView( theTimer: Timer){
           
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseOut, animations: {
            
            self.Coll.scrollToItem(at: IndexPath(row: theTimer.userInfo! as! Int, section: 0), at: .centeredHorizontally, animated: false)
        }, completion: nil)
        
    }


}
