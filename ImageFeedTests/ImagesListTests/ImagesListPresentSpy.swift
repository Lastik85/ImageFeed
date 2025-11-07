import XCTest
@testable import ImageFeed

final class ImagesListPresentSpy: ImagesListPresenterProtocol {
    var view: ImagesListControllerProtocol?
    var viewDidLoadCalled: Bool = false
    var didTapLikeCalled: Bool = false
    
    func didTapLike(for indexPath: IndexPath, with cell: ImagesListCell) {
        didTapLikeCalled = true
    }
    
    func getPhoto(for indexPath: IndexPath) -> ImageFeed.Photo {
        return Photo(id: "123test", size: CGSize.zero, createdAt: nil, welcomeDescription: nil, thumbImageURL: "thumbImageURL", largeImageURL: "largeImageURL", fullImageURL: "fullImageURL", isLiked: false)
    }
    
    func photosCount() -> Int {
        return 10
    }
    
    func updateTableView() {
        
    }
    
    func fetchPhotosNextPage() {
        
    }
    
    func fetchNewPhotosPage(for indexPath: IndexPath) {
        
    }
    
    func viewDidLoad() {
        viewDidLoadCalled = true
    }
    
    
}
