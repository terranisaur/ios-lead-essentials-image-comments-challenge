//
// Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation

public struct ImageComment {
	public let id: UUID
	public let message: String
	public let creationTime: Date
	public let authorName: String

	public init(id: UUID, message: String, creationTime: Date, authorName: String) {
		self.id = id
		self.message = message
		self.creationTime = creationTime
		self.authorName = authorName
	}
}
