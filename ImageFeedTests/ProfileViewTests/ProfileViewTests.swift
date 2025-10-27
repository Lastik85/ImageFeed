import XCTest
@testable import ImageFeed


final class ProfileViewTests: XCTestCase {
    
    func testProfileViewControllerCallViewDidLoad() {

        let viewController = ProfileViewController()
        let presenter = ProfileViewPresenterSpy()
        viewController.presenter = presenter
        presenter.view = viewController

        _ = viewController.view
 
        XCTAssertTrue(presenter.viewDidLoadCalled)
    }
    
    func testUpdateAvatar() {

        let viewController = ProfileViewControllerSpy()
        guard let url = URL(string: "https://test.com") else { return }

        viewController.updateAvatar(with: url)

        XCTAssertTrue(viewController.updateAvatarCalled)
    }
    
    func testUpdateProfile() {
        //given
        let viewController = ProfileViewControllerSpy()
        let profile = Profile(username: "testUsername", name: "testName", loginName: "@test", bio: "testBio")
        
        //when
        viewController.updateProfile(profile: profile)
        
        //then
        XCTAssertEqual(viewController.username, "testUsername")
        XCTAssertEqual(viewController.name, "testName")
        XCTAssertEqual(viewController.loginName, "@test",)
        XCTAssertEqual(viewController.bio, "testBio")
    }
    
    func testDidTapLogoutButton() {
        
        let viewController = ProfileViewControllerSpy()
        let presenter = ProfileViewPresenter()
        viewController.presenter = presenter
        presenter.view = viewController

        presenter.didTapLogoutButton()

        XCTAssertTrue(viewController.showExitAlertCalled)
        
    }
    
}
