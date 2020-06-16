//
//  TopicViewController.swift
//  Story
//
//  Created by Aries Dwi Prasetiyo on 11/06/20.
//  Copyright © 2020 Aries Dwi Prasetiyo. All rights reserved.
//

import UIKit

class TopicViewController: UICollectionViewController {

    var imageTopik:[String] = ["corona.jpg","Sekolah.jpg","rasis.jpg"]
    var namaTopic:[String] = ["Mirror Escape ","Study ","Rasis "]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        // Do any additional setup after loading the view.
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageTopik.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topic", for: indexPath) as? topicCollectionViewCell else {
            // we failed to get a PersonCell – bail out!
            fatalError("Unable to dequeue PersonCell.")
        }
        
        cell.imageView.image = UIImage(named: imageTopik[indexPath.row])
        cell.nameLabel.text = namaTopic[indexPath.row]
        // if we're still here it means we got a PersonCell, so we can return it
        return cell
    }


   

}
