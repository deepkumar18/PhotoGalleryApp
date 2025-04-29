//
//  PhotoGalleryViewModelTests.swift
//  PhotoGalleryApp
//
//  Created by Deep kumar  on 4/29/25.
//

import Foundation
import XCTest
@testable import PhotoGalleryApplication

class PhotoGalleryViewModelTests: XCTestCase {

    var viewModel: PhotoGalleryViewModel!

    override func setUp() {
        super.setUp()
        viewModel = PhotoGalleryViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testPhotosInitiallyEmpty() {
        XCTAssertEqual(viewModel.photos.count, 0)
    }

    func testSearchPhotos() {
        let expectation = self.expectation(description: "Fetching Photos")

        viewModel.didUpdatePhotos = {
            expectation.fulfill()
        }

        viewModel.searchPhotos(text: "flowers")

        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(self.viewModel.photos.count > 0)
    }
}
