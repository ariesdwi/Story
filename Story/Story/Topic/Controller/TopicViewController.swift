//
//  TopicViewController.swift
//  Story
//
//  Created by Aries Dwi Prasetiyo on 11/06/20.
//  Copyright © 2020 Aries Dwi Prasetiyo. All rights reserved.
//

import UIKit

class TopicViewController: UICollectionViewController {

    var dataTopik:[String] = ["corona.jpg","nature.jpg","rasis.jpg"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        // Do any additional setup after loading the view.
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataTopik.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topic", for: indexPath) as? topicCollectionViewCell else {
            // we failed to get a PersonCell – bail out!
            fatalError("Unable to dequeue PersonCell.")
        }
        
        cell.imageView.image = UIImage(named: dataTopik[indexPath.row])
        
        // if we're still here it means we got a PersonCell, so we can return it
        return cell
    }


   

}
