//
// Copyright © 2021 Essential Developer. All rights reserved.
//

import UIKit
import EssentialFeed

public final class ImageCommentsCellController: NSObject {
	public typealias ResourceViewModel = UIImage

	private let viewModel: ImageCommentViewModel

	public init(viewModel: ImageCommentViewModel) {
		self.viewModel = viewModel
	}
}

extension ImageCommentsCellController: UITableViewDataSource, UITableViewDelegate {
	public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		1
	}

	public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell() as ImageCommentCell
		cell.headerLabel.text = viewModel.username
		cell.dateLabel.text = viewModel.date
		cell.bodyLabel.text = viewModel.message
		return cell
	}
}
