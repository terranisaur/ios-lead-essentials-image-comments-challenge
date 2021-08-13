//
// Copyright © 2021 Essential Developer. All rights reserved.
//

import XCTest
import EssentialFeed

class ImageCommentsMapperTests: XCTestCase {
	func test_map_throwsErrorOnNon200HTTPResponse() throws {
		let samples = [199, 300, 400, 500]

		try samples.forEach { code in
			XCTAssertThrowsError(
				try ImageCommentsMapper.map(anyData(), from: HTTPURLResponse(statusCode: code))
			)
		}
	}

	func test_map_deliversInvalidDataErrorOn200HTTPResponseWithEmptyData() {
		let emptyData = Data()

		XCTAssertThrowsError(
			try ImageCommentsMapper.map(emptyData, from: HTTPURLResponse(statusCode: 200))
		)
	}

	func test_map_deliversReceivedNonEmptyDataOn200HTTPResponse() throws {
		let nonEmptyData = Data("non-empty data".utf8)

		let result = try ImageCommentsMapper.map(nonEmptyData, from: HTTPURLResponse(statusCode: 200))

		XCTAssertEqual(result, nonEmptyData)
	}
}
