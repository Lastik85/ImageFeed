import Foundation

final class ImagesListService {
    
    static let shared = ImagesListService()
    private init(){}
    
    static let didChangeNotification = Notification.Name(
        rawValue: "ImagesListServiceDidChange"
    )

    var lastLoadedPage: Int?
    private var task: URLSessionDataTask?
    let dateFormatter = ISO8601DateFormatter()
    let urlSession = URLSession.shared

    private(set) var photos: [Photo] = []

    func fetchPhotosNextPage(completion: @escaping (Result<[Photo], Error>) -> Void) {
      
        guard task == nil else {
            print("the page is still loading")
            return
        }
        let nextPage = (lastLoadedPage ?? 0) + 1
        let perPage = 10

        guard let request = makePhotoRequest(page: nextPage, perPage: perPage) else {
            print("[fetchPhotosNextPage] invalid request")
            completion(.failure(NetworkError.invalidRequest))
            return
        }

        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<[PhotoResult], Error>) in
            switch result {
            case .success(let photoResults):
                var photos: [Photo] = []
                for photoResult in photoResults {
                    guard
                        let imageURL = photoResult.urls.regular ??
                            photoResult.urls.full ??
                            photoResult.urls.raw ??
                            photoResult.urls.small ??
                            photoResult.urls.thumb
                    else { print("Не удалось получить URL изображения")
                        continue
                    }
                    
                    let photo = Photo(
                        id: photoResult.id,
                        size: CGSize(width: photoResult.width, height: photoResult.height),
                        createdAt: self?.dateFormatter.date(from: photoResult.createdAt),
                        welcomeDescription: photoResult.description,
                        thumbImageURL: imageURL,
                        largeImageURL: imageURL,
                        isLiked: photoResult.likedByUser
                    )
                    photos.append(photo)
                }
                DispatchQueue.main.async {
                    self?.photos.append(contentsOf: photos)
                    self?.lastLoadedPage = nextPage
                    NotificationCenter.default.post(
                        name: ImagesListService.didChangeNotification,
                        object: self)
                    completion(.success(photos))
                }
                
            case .failure(let error):
                print("Ошибка загрузки: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
        
        task.resume()
    }

    func makePhotoRequest(page: Int, perPage: Int) -> URLRequest? {

        guard var urlComponents = URLComponents(string: Constants.photosUrl)
            
        else {
            print("Ошибка при создании запроса: отсутствует URL")
            return nil
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "per_page", value: "\(perPage)")
        ]
        guard let token = OAuth2TokenStorage.shared.token else{
            print("Ошибка при создании запроса: отсутствует токен")
            return nil
        }

        guard let requestURL = urlComponents.url else {
            print("Не удалось сформировать URL")
            return nil
        }

        var request = URLRequest(url: requestURL)
        request.httpMethod = HttpMethods.get
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        return request
    }

}
