//
// Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation

public enum ImageCommentsEndpoint {
	case get

	public func url(baseURL: URL, imageId: UUID) -> URL {
		switch self {
		case .get:
			return baseURL.appendingPathComponent("/v1/image/\(imageId.uuidString)/comments")
		}
	}
}
