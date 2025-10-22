import UIKit
import Kingfisher

final class ImagesListCell: UITableViewCell {

    static let reuseIdentifier = "ImagesListCell"
    weak var delegate: ImagesListCellDelegate?
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var dataLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellImage.kf.cancelDownloadTask()
    }
    @IBAction private func likeButtonClicked() {
        delegate?.imageListCellDidTapLike(self)
    }
    
    func setIsLiked(_ isFavorite: Bool) {
        let imageName = isFavorite ? UIImage(resource: .active) : UIImage(resource: .noActive)
        likeButton.setImage(imageName, for: .normal)
    }
}
