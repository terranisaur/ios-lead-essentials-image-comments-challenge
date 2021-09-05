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
		let item1 = makeItem(id: UUID(),
		                     message: "a comment",
		                     creationTime: (Date(timeIntervalSince1970: 1598627222), "2020-08-28T15:07:02+00:00"),
		                     authorName: "an author")

		let item2 = makeItem(id: UUID(),
		                     message: "another comment",
		                     creationTime: (Date(timeIntervalSince1970: 1577881882), "2020-01-01T12:31:22+00:00"),
		                     authorName: "another author")

		let json = makeItemsJSON([item1.json, item2.json])

		let result = try ImageCommentsMapper.map(json, from: successfulResponseWithNon200Code)

		XCTAssertEqual(result, [item1.model, item2.model])
	}

	// MARK: - Helpers

	private func makeItem(id: UUID, message: String, creationTime: (date: Date, iso8601String: String), authorName: String) -> (model: ImageComment, json: [String: Any]) {
		let item = ImageComment(id: id, message: message, creationTime: creationTime.date, authorName: authorName)
		let json = [
			"id": id.uuidString,
			"message": message,
			"created_at": creationTime.iso8601String,
			"author": [
				"username": authorName
			]
		] as [String: Any]

		return (item, json)
	}

	private var successfulResponseWithNon200Code: HTTPURLResponse {
		HTTPURLResponse(statusCode: 201)
	}
}
