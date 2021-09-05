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
		let viewModel = ImageCommentsPresenter.map([comment]).comments.first!

		XCTAssertEqual(sut.commentUsername(at: index), viewModel.username, "username at index \(index)", file: file, line: line)
		XCTAssertEqual(sut.commentDate(at: index), viewModel.date, "date at index \(index)", file: file, line: line)
		XCTAssertEqual(sut.commentMessage(at: index), viewModel.message, "message at index \(index)", file: file, line: line)
	}
}
