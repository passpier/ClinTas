//
//  NextViewController.swift
//  ClinTas
//
//  Created by ping sheng cheng on 2019/2/28.
//  Copyright © 2019 ping sheng cheng. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {

    @IBOutlet weak var myCollectionView: UICollectionView!
    
    var placeHolders: Array<PlaceHolder> = []
    
    deinit {
        print("deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        ApiManager.fetchPlaceHolders(completeHandler: { (placeHolders) in
            self.placeHolders = placeHolders
            self.myCollectionView.reloadData()
        }, failHandler: {})
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension NextViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return placeHolders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCellIdentifier = "MyCell"
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: myCellIdentifier, for: indexPath) as! MyCell
        
        myCell.idLabel.text = String(placeHolders[indexPath.row].id)
        myCell.titleLabel.text = placeHolders[indexPath.row].title
        
        let url = URL(string: placeHolders[indexPath.row].thumbnailUrl)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                myCell.myImageView.image = UIImage(data: data!)
            }
        }
        
        return myCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenRect = UIScreen.main.bounds
        let cellWidth = screenRect.size.width/4
        
        return CGSize(width: cellWidth, height: 200)
    }
    
}
