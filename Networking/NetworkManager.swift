//
//  NetworkManager.swift
//  PhotoGalleryApp
//
//  Created by Deep kumar  on 4/29/25.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private let session: URLSession

    private init() {
        session = URLSession(configuration: .default)
    }

    func fetchPhotos(searchText: String, completion: @escaping (Result<[PicsumPhoto], Error>) -> Void) {
        let urlString = "https://picsum.photos/v2/list"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }

        session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                return
            }

            do {
                let result = try JSONDecoder().decode([PicsumPhoto].self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
