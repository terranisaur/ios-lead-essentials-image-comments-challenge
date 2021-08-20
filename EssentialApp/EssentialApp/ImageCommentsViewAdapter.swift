//
// Copyright © 2021 Essential Developer. All rights reserved.
//

import UIKit
import EssentialFeed
import EssentialFeediOS

final class ImageCommentsViewAdapter: ResourceView {
	private weak var controller: ListViewController?

	init(controller: ListViewController) {
		self.controller = controller
	}

	func display(_ viewModel: ImageCommentsViewModel) {
		controller?.display(viewModel.comments.map { model in
			let view = ImageCommentsCellController(viewModel: model)
			return CellController(id: model, view)
		})
	}
}
