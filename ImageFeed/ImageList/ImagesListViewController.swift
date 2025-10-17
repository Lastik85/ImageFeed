import UIKit
import Kingfisher

final class ImagesListViewController: UIViewController {
    
 
    @IBOutlet private weak var tableView: UITableView!
    let imagesListService = ImagesListService.shared

   // private let photosName = (0..<20).map { String($0) }
    private let showSingleImageSegueIdentifier = "ShowSingleImage"

    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        fetchImage()
       
    }

    private func fetchImage() {
     imagesListService.fetchPhotosNextPage() { result in
         DispatchQueue.main.async {
             switch result {
             case .success:
                 self.tableView.reloadData()
             case .failure(let error):
                 print("Ошибка загрузки фото: \(error)")
             }
         }
     }
    }

}

// MARK: - UITableViewDataSource
extension ImagesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int {
            return imagesListService.photos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ImagesListCell.reuseIdentifier,
            for: indexPath)

        guard let imageListCell = cell as? ImagesListCell else {
            return UITableViewCell()
        }
        configureCell(for: imageListCell, with: indexPath)
        return imageListCell
    }
}

// MARK: - Cell Configuration
extension ImagesListViewController {
    func configureCell(for cell: ImagesListCell, with indexPath: IndexPath) {

        let url = URL(string: imagesListService.photos[indexPath.row].thumbImageURL)
        
        cell.cellImage.kf.indicatorType = .activity
        cell.cellImage.kf.setImage(with: url, placeholder: UIImage(resource: .stub))
        cell.dataLabel.text = dateFormatter.string(from: Date())
        let isLiked = indexPath.row % 2 == 0
        let likeImage = isLiked ? UIImage(named: "Active") : UIImage(named: "No Active")
        cell.likeButton.setImage(likeImage, for: .normal)
    }
}

// MARK: - UITableViewDelegate
extension ImagesListViewController: UITableViewDelegate {
    func tableView(  _ tableView: UITableView,  didSelectRowAt indexPath: IndexPath ) {
        performSegue( withIdentifier: showSingleImageSegueIdentifier, sender: indexPath )
    }
    func tableView( _ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        let imagesCount = imagesListService.photos.count
        if indexPath.row == imagesCount - 1 {
            fetchImage()
        }
    }
    
    
    func tableView(_ tableView: UITableView,heightForRowAt indexPath: IndexPath) -> CGFloat {
        let photos = imagesListService.photos
        let imageInsets = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        let imageViewWidth = tableView.bounds.width - imageInsets.left - imageInsets.right
 
        let imageWidth = photos[indexPath.row].size.width
        let imageHeight = photos[indexPath.row].size.height
 
        let scale = imageViewWidth / imageWidth
        let cellHeight = imageHeight * scale + imageInsets.top + imageInsets.bottom
 
        return cellHeight
     
    }
}
