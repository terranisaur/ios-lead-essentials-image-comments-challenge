//
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import XCTest
import EssentialFeed
import EssentialFeediOS

extension ImageCommentsUIIntegrationTests {
	func assertThat(_ sut: ListViewController, isRendering comments: [ImageComment], file: StaticString = #filePath, line: UInt = #line) {
		sut.view.enforceLayoutCycle()

		guard sut.numberOfRenderedImageComments() == comments.count else {
			return XCTFail("Expected \(comments.count) comments, got \(sut.numberOfRenderedImageComments()) instead.", file: file, line: line)
		}

		comments.enumerated().forEach { index, comment in
			assertThat(sut, hasViewConfiguredFor: comment, at: index, file: file, line: line)
		}

		executeRunLoopToCleanUpReferences()
	}

	func assertThat(_ sut: ListViewController, hasViewConfiguredFor comment: ImageComment, at index: Int, file: StaticString = #filePath, line: UInt = #line) {
		let view = sut.imageCommentView(at: index)

		guard let cell = view as? ImageCommentCell else {
			return XCTFail("Expected \(ImageCommentCell.self) instance, got \(String(describing: view)) instead", file: file, line: line)
		}

		let viewModel = ImageCommentsPresenter.map([comment]).comments.first!

		XCTAssertEqual(cell.headerLabel.text, viewModel.username, "Expected username text to be \(String(describing: viewModel.username)) for image  view at index (\(index))", file: file, line: line)

		XCTAssertEqual(cell.dateLabel.text, viewModel.date, "Expected username text to be \(String(describing: viewModel.date)) for image  view at index (\(index))", file: file, line: line)

		XCTAssertEqual(cell.bodyLabel.text, viewModel.message, "Expected body text to be \(String(describing: viewModel.message)) for image  view at index (\(index))", file: file, line: line)
	}
}
