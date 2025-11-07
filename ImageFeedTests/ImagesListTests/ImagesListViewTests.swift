import XCTest
@testable import ImageFeed

final class ImagesListTest: XCTestCase {
    
    @MainActor
    func testViewControllerCallsDidLoad() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ImagesListViewController") as! ImagesListViewController
        let presenter = ImagesListPresentSpy()
        viewController.configure(presenter: presenter)
        presenter.view = viewController
        
        _ = viewController.view
        
        XCTAssertTrue(presenter.viewDidLoadCalled)
    }
    
    func testGetPhoto() {
        let presenter = ImagesListPresentSpy()
        let testPhoto = Photo(id: "123test", size: CGSize.zero, createdAt: nil, welcomeDescription: nil, thumbImageURL: "thumbImageURL", largeImageURL: "largeImageURL", fullImageURL: "fullImageURL", isLiked: false)
        let indexPath = IndexPath(row: 0, section: 0)
        
        let presenterPhoto = presenter.getPhoto(for: indexPath)
        
        XCTAssertEqual(testPhoto.id, presenterPhoto.id)
        XCTAssertEqual(testPhoto.size, presenterPhoto.size)
        XCTAssertEqual(testPhoto.createdAt, presenterPhoto.createdAt)
        XCTAssertEqual(testPhoto.welcomeDescription, presenterPhoto.welcomeDescription)
        XCTAssertEqual(testPhoto.thumbImageURL, presenterPhoto.thumbImageURL)
        XCTAssertEqual(testPhoto.largeImageURL, presenterPhoto.largeImageURL)
        XCTAssertEqual(testPhoto.fullImageURL, presenterPhoto.fullImageURL)
        XCTAssertEqual(testPhoto.isLiked, presenterPhoto.isLiked)
    }
    
    func testDidTapLikeCalled() {
        let viewController = ImagesListControllerSpy()
        let presenter = ImagesListPresentSpy()
        viewController.configure(presenter: presenter)
        presenter.view = viewController
        
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = ImagesListCell()
        
        presenter.didTapLike(for: indexPath, with: cell)
        
        XCTAssertTrue(presenter.didTapLikeCalled)
    }
    
    func testUpdateTableViewAnimatedCalled() {
        
        let viewController = ImagesListControllerSpy()
        
        viewController.updateTableViewAnimated(with: 0, newCount: 1)
        
        XCTAssertTrue(viewController.updateTableViewAnimatedCalled)
    }
    
}
