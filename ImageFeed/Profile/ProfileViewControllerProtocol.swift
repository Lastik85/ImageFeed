import Foundation

public protocol ProfileViewControllerProtocol: AnyObject {
    var presenter: ProfileViewPresenterProtocol? { get set }
    func updateAvatar(with url: URL)
    func updateProfile(profile: Profile)
    func showExitAllert()

}
