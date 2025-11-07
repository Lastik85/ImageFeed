import Foundation

protocol ImagesListControllerProtocol: AnyObject {
    var presenter: ImagesListPresenterProtocol? { get set }
    
    func showProgressHUD()
    func hideProgressHUD()
    func updateTableViewAnimated(with oldCount: Int, newCount: Int)
    
}
