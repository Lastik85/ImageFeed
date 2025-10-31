import Foundation

final class ImagesListPresenter: ImagesListPresenterProtocol {
    
    weak var view: ImagesListControllerProtocol?
    private let imagesService = ImagesListService.shared
    var photos: [Photo] = []
    
    func viewDidLoad() {
        fetchPhotosNextPage()
        updateTableView()
    }
    
    func getPhoto(for indexPath: IndexPath) -> Photo {
        photos[indexPath.row]
    }
    
    func photosCount() -> Int {
        photos.count
    }
    
    func fetchPhotosNextPage(){
        imagesService.fetchPhotosNextPage() { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    break
                case .failure(let error):
                    print("Ошибка загрузки фото: \(error)")
                }
            }
        }
    }
    
    func didTapLike(for indexPath: IndexPath, with cell: ImagesListCell) {
        let photo = photos[indexPath.row]
        view?.showProgressHUD()
        
        imagesService.changeLike(photoId: photo.id, isLike: !photo.isLiked) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success:
                DispatchQueue.main.async {
                    if let index = self.photos.firstIndex(where: { $0.id == photo.id }) {
                        self.photos[index].isLiked = !photo.isLiked
                        cell.setIsLiked(!photo.isLiked)
                    }
                }
                self.view?.hideProgressHUD()
            case .failure:
                self.view?.hideProgressHUD()
            }
        }
    }
    
    func updateTableView() {
        let oldCount = photos.count
        let newCount = imagesService.photos.count
        photos = imagesService.photos
        if oldCount != newCount {
            view?.updateTableViewAnimated(with: oldCount, newCount: newCount)
        }
    }
    
    func fetchNewPhotosPage(for indexPath: IndexPath) {
        if indexPath.row + 1 == photos.count {
            fetchPhotosNextPage()
        }
    }
}
