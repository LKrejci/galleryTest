//
//  ViewController.swift
//  Gallery
//
//  Created by Lucas Krejci Ferreira on 04/07/20.
//  Copyright © 2020 Lucas Krejci Ferreira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageColletionView: UICollectionView!
    
    var listImage: [UIImage]? {
        didSet {
            imageColletionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectioView()
        
        let request = GalleryRequest()
        request.getCatURLImages { images in
            self.listImage = images
        }
    }
    
    func configCollectioView() {
        imageColletionView.register(ImageCollectionViewCell.nib(), forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listImage?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as! ImageCollectionViewCell
        
        guard listImage?.count ?? 0 > 1 else { return cell }
        
        if let image = listImage?[indexPath.row] {
            cell.setImage(image)
        }
        
        return cell
    }
}
