//
// Copyright © 2021 Essential Developer. All rights reserved.
//

import XCTest
import EssentialFeed

class ImageCommentsEndpointTests: XCTestCase {
	func test_comments_endpointURL() {
		let baseURL = URL(string: "http://base-url.com")!

		let uuid = UUID()
		let received = CommentsEndpoint.get.url(baseURL: baseURL, imageId: uuid)
		let expected = URL(string: "http://base-url.com/v1/image/\(uuid.uuidString)/comments")!

		XCTAssertEqual(received, expected)
	}
}
