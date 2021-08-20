//
// Copyright © 2021 Essential Developer. All rights reserved.
//

import UIKit
import EssentialFeed

public final class ImageCommentsCellController: NSObject {
	public typealias ResourceViewModel = UIImage

//	private let viewModel: ImageCommentsViewModel
	private let viewModel: ImageComment
	private var cell: ImageCommentCell?

	public init(viewModel: ImageComment) {
		self.viewModel = viewModel
	}

	static let dateFormatter: DateFormatter = {
		let f = DateFormatter()
		f.dateStyle = .short
		return f
	}()
}

extension ImageCommentsCellController: UITableViewDataSource, UITableViewDelegate {
	public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		1
	}

	public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		cell = tableView.dequeueReusableCell()
		cell?.headerLabel.text = viewModel.authorName
		cell?.dateLabel.text = Self.dateFormatter.string(from: viewModel.creationTime)
		cell?.bodyLabel.text = viewModel.message
		return cell!
	}

	public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		cancelLoad()
	}

	private func cancelLoad() {
		releaseCellForReuse()
	}

	private func releaseCellForReuse() {
		cell = nil
	}
}
