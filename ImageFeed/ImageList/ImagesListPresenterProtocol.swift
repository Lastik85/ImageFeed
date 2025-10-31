import Foundation

protocol ImagesListPresenterProtocol: AnyObject {
    var view: ImagesListControllerProtocol? { get set }
    func didTapLike(for indexPath: IndexPath, with cell: ImagesListCell)
    func getPhoto(for indexPath: IndexPath) -> Photo
    func photosCount() -> Int
    func updateTableView()
    func fetchPhotosNextPage()
    func fetchNewPhotosPage(for indexPath: IndexPath)
    func viewDidLoad()
}
