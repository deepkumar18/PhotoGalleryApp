//
//  PhotoGalleryViewController.swift
//  PhotoGalleryApp
//
//  Created by Deep kumar  on 4/29/25.
//

import Foundation
import UIKit

class PhotoGalleryViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let viewModel = PhotoGalleryViewModel()
    private let reuseIdentifier = "PhotoCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        viewModel.didUpdatePhotos = { [weak self] in
            self?.collectionView.reloadData()
        }

        viewModel.searchPhotos(text: "nature")
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        let photo = viewModel.photos[indexPath.item]
        cell.configure(with: photo)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width / 2) - 10
        return CGSize(width: width, height: width)
    }
}
