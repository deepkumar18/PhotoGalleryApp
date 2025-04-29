//
//  PhotoGalleryViewModel.swift
//  PhotoGalleryApp
//
//  Created by Deep kumar  on 4/29/25.
//

import Foundation

class PhotoGalleryViewModel {
    private(set) var photos: [PicsumPhoto] = []
    var didUpdatePhotos: (() -> Void)?

    func searchPhotos(text: String) {
        NetworkManager.shared.fetchPhotos(searchText: text) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let photos):
                    self?.photos = photos
                    self?.didUpdatePhotos?()
                case .failure(let error):
                    print("Failed to fetch photos: \(error)")
                }
            }
        }
    }
}
