import XCTest
@testable import ImageFeed

final class ProfileViewPresenterSpy: ProfileViewPresenterProtocol{
    
    var view: ProfileViewControllerProtocol?
    var viewDidLoadCalled: Bool = false
    
    func logout() { }
    
    func viewDidLoad() {
        viewDidLoadCalled = true
    }
    
    func didTapLogoutButton() { }
    
    func updateAvatar() { }
    
    func updateProfile() { }
    
}
