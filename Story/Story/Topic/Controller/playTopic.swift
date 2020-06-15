//
//  playTopic.swift
//  Story
//
//  Created by Aries Dwi Prasetiyo on 12/06/20.
//  Copyright © 2020 Aries Dwi Prasetiyo. All rights reserved.
//

import UIKit



class playTopic: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    var aryData:[String] = ["1","2","3","4","5","6","7","8","9","10","1","2","3","4","5","6","7","8","9","10"]
    
    let layout = UICollectionViewFlowLayout()

    var scrollingtimer = Timer()
    
    @IBOutlet var CollectionVieww: UICollectionView!
    
    var isiFloat = 120
  
   

    override func viewDidLoad() {
        super.viewDidLoad()
        layout.scrollDirection = .vertical
        startTimer()
        collectionView.backgroundColor = .white
           
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return aryData.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "playtopiccell", for: indexPath) as? playTopicCell else {
                    // we failed to get a PersonCell – bail out!
                    fatalError("Unable to dequeue PersonCell.")
                }
        
        if indexPath.row == 0 {
            cell.backgroundColor = .blue
        } else {
            cell.backgroundColor = .red
        }
        var rowIndex = indexPath.row
        let numberOfrecords:Int = 9
        if (rowIndex < numberOfrecords){
            rowIndex = (rowIndex + 1)
        }else {
            rowIndex = 0
        }
        
        var index = indexPath.item
        if index > aryData.count - 1 {
            index -= aryData.count
           
        }
        cell.displayLabel.text = aryData[index % aryData.count]
        
        return cell
    }
    
    func startTimer(){
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.scrollToView), userInfo: nil, repeats: true)
    }
    
    @objc func scrollToView(_ timer1: Timer){
        func scroll(){
            if let coll = CollectionVieww {
                for cell in coll.visibleCells{
                    let indexPath: IndexPath? = coll.indexPath(for: cell)
                    if (indexPath!.row < aryData.count - 1) {
                        let indexPath1: IndexPath?
                        
                        indexPath1 = IndexPath.init(row:(indexPath?.row)! + 1 , section: 0 )

                        coll.scrollToItem(at: indexPath1!, at: .top, animated: true)
                    } else {
                        let indexPath1: IndexPath?
                        indexPath1 = IndexPath.init(row:(indexPath?.row)! ,section:(indexPath?.section)!)
                        coll.scrollToItem(at: indexPath1!, at: .bottom, animated: true)
                        print("Kondisi else \(indexPath1!)")
                    }
                }
            }
        }
    }
    
    
    
    
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
      
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        var widthLayout = view.frame.width-60
        var heightLayout = CGFloat(isiFloat)
               
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
