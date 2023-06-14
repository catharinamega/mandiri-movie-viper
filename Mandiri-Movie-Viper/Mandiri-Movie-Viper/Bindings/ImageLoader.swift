//
//  ImageLoader.swift
//  Mandiri-Movie-Viper
//
//  Created by Catharina Adinda Mega Cahyani on 13/06/23.
//

import SwiftUI
import UIKit
import Kingfisher


private let _imageCache = NSCache<AnyObject, AnyObject>()

class ImageLoader: ObservableObject {
    
    @Published var image: UIImage?
    @Published var isLoading = false
    
    var imageCache = _imageCache

//    WITHOUT URL SESSION
    
    func loadImage(with url: URL) {
        let urlString = url.absoluteString
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }

        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            do {
                let data = try Data(contentsOf: url)
                guard let image = UIImage(data: data) else {
                    return
                }
                self.imageCache.setObject(image, forKey: urlString as AnyObject)
                DispatchQueue.main.async { [weak self] in
                    self?.image = image
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
//    WITH URL SESSION
    
//    func loadImage(with url: URL) {
//        let urlString = url.absoluteString
//
//        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
//            self.image = imageFromCache
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
//            guard let self = self, let data = data, error == nil else {
//                print(error?.localizedDescription ?? "Error loading image")
//                return
//            }
//
//            DispatchQueue.main.async { [weak self] in
//                guard let self = self else { return }
//
//                if let image = UIImage(data: data) {
//                    self.imageCache.setObject(image, forKey: urlString as AnyObject)
//                    self.image = image
//                }
//            }
//        }.resume()
//    }

    
//     USING KINGFISHER
    
//    func loadImage(with url: URL) {
//        let urlString = url.absoluteString
//        if let imageFromCache = ImageCache.default.retrieveImageInMemoryCache(forKey: urlString) {
//            self.image = imageFromCache
//            return
//        }
//
//        let options: KingfisherOptionsInfo = [
//            .transition(.fade(0.2)),
//            .cacheOriginalImage
//        ]
//
//        let downloader = ImageDownloader.default
//        downloader.downloadImage(with: url, options: options, completionHandler: { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .success(let value):
//                self.image = value.image
//                ImageCache.default.store(value.image, forKey: urlString)
//            case .failure(let error):
//                print("Error loading image: \(error.localizedDescription)")
//            }
//        })
//    }


}
