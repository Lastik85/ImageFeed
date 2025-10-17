import UIKit
import Kingfisher

final class ImagesListCell: UITableViewCell {

    static let reuseIdentifier = "ImagesListCell"
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var dataLabel: UILabel!
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        
//        // Отменяем загрузку, чтобы избежать багов при переиспользовании ячеек
//        fullsizeImageView.kf.cancelDownloadTask()
//    }
}
