//
// Copyright © 2021 Essential Developer. All rights reserved.
//

import UIKit
import Combine
import EssentialFeed
import EssentialFeediOS

public final class CommentsUIComposer {
	private init() {}

	private typealias CommentsPresentationAdapter = LoadResourcePresentationAdapter<[ImageComment], ImageCommentsViewAdapter>

	public static func composedWith(loader: @escaping () -> AnyPublisher<[ImageComment], Error>) -> ListViewController {
		let presentationAdapter = CommentsPresentationAdapter(loader: loader)

		let commentsController = makeCommentsViewController(title: ImageCommentsPresenter.title)
		commentsController.onRefresh = presentationAdapter.loadResource

		presentationAdapter.presenter = LoadResourcePresenter(
			resourceView: ImageCommentsViewAdapter(controller: commentsController),
			loadingView: WeakRefVirtualProxy(commentsController),
			errorView: WeakRefVirtualProxy(commentsController),
			mapper: { ImageCommentsPresenter.map($0) })

		return commentsController
	}

	private static func makeCommentsViewController(title: String) -> ListViewController {
		let bundle = Bundle(for: ListViewController.self)
		let storyboard = UIStoryboard(name: "ImageComments", bundle: bundle)
		let feedController = storyboard.instantiateInitialViewController() as! ListViewController
		feedController.title = title
		return feedController
	}
}
