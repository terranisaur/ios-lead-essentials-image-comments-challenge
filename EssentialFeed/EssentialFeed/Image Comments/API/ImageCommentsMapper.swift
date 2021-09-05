//
// Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation

public final class ImageCommentsMapper {
	private struct Root: Decodable {
		private let items: [RemoteImageComment]

		private struct RemoteImageComment: Decodable {
			let id: UUID
			let message: String
			let created_at: Date
			let author: RemoteAuthor
		}

		private struct RemoteAuthor: Decodable {
			let username: String
		}

		var comments: [ImageComment] {
			items.map { ImageComment(id: $0.id, message: $0.message, creationTime: $0.created_at, authorName: $0.author.username) }
		}
	}

	public enum Error: Swift.Error {
		case invalidData
	}

	public static func map(_ data: Data, from response: HTTPURLResponse) throws -> [ImageComment] {
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .iso8601

		guard response.is2xx, let root = try? decoder.decode(Root.self, from: data) else {
			throw Error.invalidData
		}

		return root.comments
	}
}

extension HTTPURLResponse {
	var is2xx: Bool {
		(200 ..< 300).contains(statusCode)
	}
}
