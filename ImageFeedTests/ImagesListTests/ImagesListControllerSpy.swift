import XCTest
@testable import ImageFeed

final class ImagesListControllerSpy: ImagesListControllerProtocol {
    var presenter: ImagesListPresenterProtocol?
    var updateTableViewAnimatedCalled: Bool = false
    
    func showProgressHUD() { }
    
    func hideProgressHUD() { }
    
    func updateTableViewAnimated(with oldCount: Int, newCount: Int) {
        updateTableViewAnimatedCalled = true
    }
    
    var didFetchPhotos: Bool = false
    
    func fetchPhotos() {
        didFetchPhotos = true
    }
    
    func configure(presenter: ImagesListPresenterProtocol) {
        self.presenter = presenter
    }
}
