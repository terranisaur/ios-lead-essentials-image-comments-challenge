//
// Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation

public final class ImageCommentsPresenter {
	public static var title: String {
		NSLocalizedString(
			"IMAGE_COMMENTS_TITLE",
			tableName: "ImageComments",
			bundle: Bundle(for: ImageCommentsPresenter.self),
			comment: "Title for the image comments view")
	}

	public static func map(_ comments: [ImageComment],
	                       currentDate: Date = Date(),
	                       calendar: Calendar = .current,
	                       locale: Locale = .current
	) -> ImageCommentsViewModel {
		let formatter = RelativeDateTimeFormatter()
		formatter.calendar = calendar
		formatter.locale = locale

		return ImageCommentsViewModel(comments: comments.map { comment -> ImageCommentViewModel in
			ImageCommentViewModel(
				message: comment.message,
				date: formatter.localizedString(for: comment.creationTime, relativeTo: currentDate),
				username: comment.authorName)
		})
	}
}
