import UIKit

protocol AuthViewControllerDelegate: AnyObject {

    func didAuthenticate(_ vc: AuthViewController)

}

final class AuthViewController: UIViewController {

    private let showWebViewSegueIdentifier = "ShowWebView"
    private let oauth2Service = OAuth2Service.shared
    weak var delegate: AuthViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackButton()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showWebViewSegueIdentifier {
            guard
                let webViewViewController = segue.destination
                    as? WebViewViewController
            else {
                assertionFailure(
                    "Failed to prepare for \(showWebViewSegueIdentifier)"
                )
                return
            }
            webViewViewController.delegate = self
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }

    private func configureBackButton() {
        navigationController?.navigationBar.backIndicatorImage = UIImage(
            named: "nav_back_button"
        )
        navigationController?.navigationBar.backIndicatorTransitionMaskImage =
            UIImage(named: "nav_back_button")
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil
        )
        navigationItem.backBarButtonItem?.tintColor = UIColor(
            named: "YP Black (iOS)"
        )
    }
}
extension AuthViewController: WebViewViewControllerDelegate {

    func webViewViewController(
        _ vc: WebViewViewController,
        didAuthenticateWithCode code: String
    ) {
        vc.navigationController?.popViewController(animated: true)

        oauth2Service.fetchOAuthToken(code: code) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let access_token):
                let oauth2TokenStorage = OAuth2TokenStorage()
                oauth2TokenStorage.token = access_token
                print("Получен токен: \(oauth2TokenStorage.token!)")
                self.delegate?.didAuthenticate(self)

            case .failure(let error):
                print(error)
            }
        }
    }
    func webViewViewControllerDidCancel(_ vc: WebViewViewController) {
        dismiss(animated: true)
    }
}
