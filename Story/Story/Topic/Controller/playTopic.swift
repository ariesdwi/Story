//
//  playTopic.swift
//  Story
//
//  Created by Aries Dwi Prasetiyo on 12/06/20.
//  Copyright © 2020 Aries Dwi Prasetiyo. All rights reserved.
//

import UIKit



class playTopic: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

   


}


extension playTopic: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return 10
       }

      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "playtopiccell", for: indexPath) as? playTopicCell else {
               // we failed to get a PersonCell – bail out!
               fatalError("Unable to dequeue PersonCell.")
           }

           // if we're still here it means we got a PersonCell, so we can return it
           return cell
       }
}
