//
// Copyright © 2021 Essential Developer. All rights reserved.
//

import XCTest
import EssentialFeediOS
@testable import EssentialFeed

class ImageCommentsSnapshotTests: XCTestCase {
	func test_loadingComments() {
		let sut = makeSUT()

		sut.display(ResourceLoadingViewModel(isLoading: true))

		assert(snapshot: sut.snapshot(for: .iPhone8(style: .light)), named: "COMMENTS_LOADING_light")
		assert(snapshot: sut.snapshot(for: .iPhone8(style: .dark)), named: "COMMENTS_LOADING_dark")
	}

	func test_commentsFailedLoading() {
		let sut = makeSUT()

		sut.display(ResourceErrorViewModel(message: "a multiline\nerror message\nwith description"))

		assert(snapshot: sut.snapshot(for: .iPhone8(style: .light)), named: "COMMENTS_FAILED_LOADING_light")
		assert(snapshot: sut.snapshot(for: .iPhone8(style: .dark)), named: "COMMENTS_FAILED_LOADING_dark")
	}

	func test_loadedComments() {
		let sut = makeSUT()

		sut.display(loadedComments().map { CellController(id: UUID(), $0) })

		record(snapshot: sut.snapshot(for: .iPhone8(style: .light)), named: "COMMENTS_WITH_CONTENT_light")
		record(snapshot: sut.snapshot(for: .iPhone8(style: .dark)), named: "COMMENTS_WITH_CONTENT_dark")
		record(snapshot: sut.snapshot(for: .iPhone8(style: .light, contentSize: .extraExtraExtraLarge)), named: "COMMENTS_WITH_CONTENT_light_extraExtraExtraLarge")
	}

	// MARK: - Helpers

	private func makeSUT() -> ListViewController {
		let bundle = Bundle(for: ListViewController.self)
		let storyboard = UIStoryboard(name: "ImageComments", bundle: bundle)
		let controller = storyboard.instantiateInitialViewController() as! ListViewController
		controller.loadViewIfNeeded()
		controller.tableView.showsVerticalScrollIndicator = false
		controller.tableView.showsHorizontalScrollIndicator = false
		return controller
	}

	func loadedComments() -> [ImageCommentsCellController] {
		[ImageCommentViewModel(message: "a place", date: "1 hour ago", username: "a"),
		 ImageCommentViewModel(message: "Great\nView!", date: "10 day ago", username: "a username"),
		 ImageCommentViewModel(message: "The East Side Gallery is an open-air gallery in Berlin. It consists of a series of murals painted directly on a 1,316 m long remnant of the Berlin Wall, located near the centre of Berlin, on Mühlenstraße in Friedrichshain-Kreuzberg. The gallery has official status as a Denkmal, or heritage-protected landmark.", date: "1000 years ago", username: "a long long long username")]
			.map { ImageCommentsCellController(viewModel: $0) }
	}
}
