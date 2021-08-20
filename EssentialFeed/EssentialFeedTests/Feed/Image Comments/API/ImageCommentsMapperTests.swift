//
// Copyright © 2021 Essential Developer. All rights reserved.
//

import XCTest
import EssentialFeed

class ImageCommentsMapperTests: XCTestCase {
	func test_map_throwsErrorOnNon2xxHTTPResponse() throws {
		let samples = [199, 300, 400, 500]

		try samples.forEach { code in
			XCTAssertThrowsError(
				try ImageCommentsMapper.map(anyData(), from: HTTPURLResponse(statusCode: code))
			)
		}
	}

	func test_map_deliversInvalidDataErrorOn2xxHTTPResponseWithEmptyData() {
		let emptyData = Data()

		XCTAssertThrowsError(
			try ImageCommentsMapper.map(emptyData, from: successfulResponseWithNon200Code)
		)
	}

	func test_map_throwsErrorOn2xxHTTPResponseWithInvalidJSON() {
		let invalidJSON = Data("invalid json".utf8)

		XCTAssertThrowsError(
			try ImageCommentsMapper.map(invalidJSON, from: successfulResponseWithNon200Code)
		)
	}

	func test_map_deliversNoItemsOn2xxHTTPResponseWithEmptyJSONList() throws {
		let emptyListJSON = makeItemsJSON([])

		let result = try ImageCommentsMapper.map(emptyListJSON, from: successfulResponseWithNon200Code)

		XCTAssertEqual(result, [])
	}

	func test_map_deliversItemsOn2xxHTTPResponseWithJSONItems() throws {
		let date = Date()
		let item1 = makeItem(id: UUID(),
		                     message: "a comment",
		                     creationTime: date,
		                     authorName: "an author")

		let item2 = makeItem(id: UUID(),
		                     message: "another comment",
		                     creationTime: date,
		                     authorName: "another author")

		let json = makeItemsJSON([item1.json, item2.json])

		let result = try ImageCommentsMapper.map(json, from: successfulResponseWithNon200Code)

		XCTAssertEqual(result, [item1.model, item2.model])
	}

	// MARK: - Helpers

	private func makeItem(id: UUID, message: String, creationTime: Date, authorName: String) -> (model: ImageComment, json: [String: Any]) {
		let formatter = ISO8601DateFormatter()
		let iso8601date = formatter.date(from: formatter.string(from: creationTime))!
		let item = ImageComment(id: id, message: message, creationTime: iso8601date, authorName: authorName)

		let json = [
			"id": id.uuidString,
			"message": message,
			"created_at": formatter.string(from: iso8601date),
			"author": [
				"username": authorName
			]
		].compactMapValues { $0 }

		return (item, json)
	}

	private var successfulResponseWithNon200Code: HTTPURLResponse {
		HTTPURLResponse(statusCode: 201)
	}
}
