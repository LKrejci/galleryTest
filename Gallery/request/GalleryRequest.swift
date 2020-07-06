//
//  GalleryRequest.swift
//  Gallery
//
//  Created by Lucas Krejci Ferreira on 05/07/20.
//  Copyright © 2020 Lucas Krejci Ferreira. All rights reserved.
//

import Foundation
import Alamofire

class GalleryRequest {
    
    let url = "https://api.imgur.com/3/gallery/search/?q=cats"
    let headers = ["Authorization": "Client-ID 1ceddedc03a5d71"]
    
    func getCatURLImages(_ sucess: @escaping ([UIImage]) -> Void) {
        var urlImageList = [""]
        
        AF.request(url, headers: ["Authorization": "Client-ID 1ceddedc03a5d71"]).responseJSON{ response in
            let json = try? JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as? [String: Any]
            print(json!)
            if let data = json?["data"] as? [[String: Any]] {
                for eachData in data {
                    if let images = eachData["images"] as? [[String: Any]] {
                        for image in images {
                            urlImageList.append(image["link"] as! String)
                        }
                    }
                }
                
                urlImageList.removeFirst()
                
                let cleanedList = urlImageList.filter {
                    $0.contains(String(".jpg"))
                    
                }
                
                self.getImages(cleanedList) { images in
                    sucess(images)
                }
            }
        }
    }
    
    func getImages(_ urls: [String], _ sucess: @escaping ([UIImage]) -> Void) {
        var images: [UIImage] = []
        
        for url in urls {
            DispatchQueue.global().async {
                if let newUrl = URL(string: url) {
                    if let data = try? Data(contentsOf: newUrl) {
                        DispatchQueue.main.async {
                            if let image = UIImage(data: data) {
                                images.append(image)
                                sucess(images)
                            }
                        }
                    }
                }
            }
        }
    }
}
