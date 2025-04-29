//
//  ImageCacheManager.swift
//  PhotoGalleryApp
//
//  Created by Deep kumar  on 4/29/25.
//

import Foundation
import UIKit

class ImageCacheManager {
    static let shared = ImageCacheManager()
    private let cache = NSCache<NSURL, UIImage>()

    private init() {}

    func image(for url: NSURL) -> UIImage? {
        return cache.object(forKey: url)
    }

    func setImage(_ image: UIImage, for url: NSURL) {
        cache.setObject(image, forKey: url)
    }
}
