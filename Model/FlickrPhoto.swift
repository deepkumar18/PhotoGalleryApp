//
//  FlickrPhoto.swift
//  PhotoGalleryApp
//
//  Created by Deep kumar  on 4/29/25.
//

import Foundation

struct FlickrPhoto: Codable {
    let id: String
    let secret: String
    let server: String
    let farm: Int

    var imageUrl: URL? {
        return URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_m.jpg")
    }
}

struct FlickrResponse: Codable {
    let photos: FlickrPhotos
}

struct FlickrPhotos: Codable {
    let photo: [FlickrPhoto]
}

struct PicsumPhoto: Codable {
    let id: String
    let download_url: String?

    func toFlickrPhoto() -> FlickrPhoto {
        return FlickrPhoto(id: id, secret: "", server: "", farm: 0)
    }
}
