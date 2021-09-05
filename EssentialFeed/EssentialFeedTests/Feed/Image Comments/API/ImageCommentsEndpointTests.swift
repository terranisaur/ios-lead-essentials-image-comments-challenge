//
// Copyright © 2021 Essential Developer. All rights reserved.
//

import XCTest
import EssentialFeed

class ImageCommentsEndpointTests: XCTestCase {
	func test_comments_endpointURL() {
		let baseURL = URL(string: "http://base-url.com")!

		let uuid = UUID(uuidString: "2AB2AE66-A4B7-4A16-B374-51BBAC8DB086")!
		let received = ImageCommentsEndpoint.get.url(baseURL: baseURL, imageId: uuid)
		let expected = URL(string: "http://base-url.com/v1/image/2AB2AE66-A4B7-4A16-B374-51BBAC8DB086/comments")!

		XCTAssertEqual(received, expected)
	}
}
