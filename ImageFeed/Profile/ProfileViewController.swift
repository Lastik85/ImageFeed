import UIKit
import Kingfisher

final class ProfileViewController: UIViewController {
    
    private var photoImage = UIImage()
    private var avatarImageView = UIImageView()
    private var exitButton = UIButton()
    private let nameLabel = UILabel()
    private let loginNameLable = UILabel()
    private let textLabel = UILabel()
    private var profileImageServiceObserver: NSObjectProtocol?
    private let profileLogoutService = ProfileLogoutService.shared
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupUIElements()
        if let profile = ProfileService.shared.profile {
            updateProfileDetails(profile: profile)
        }
        setupObserver()
        updateAvatar()
        
    }
    
    // MARK: - View Setup
    private func setupView() {
        view.contentMode = .scaleToFill
        view.backgroundColor = UIColor(resource: .ypBlackIOS)
    }
    
    // MARK: - AvatarImageView Setup
    private func setupAvatarImageView() {
        avatarImageView = UIImageView()
        avatarImageView.layer.cornerRadius = 35
        avatarImageView.clipsToBounds = true
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.backgroundColor = .clear
        view.addSubview(avatarImageView)
    }
    
    // MARK: - ExitButton Setup
    private func setupExitButton() {
        exitButton = UIButton.systemButton(
            with: UIImage(resource: .logout),
            target: self,
            action: #selector(didTapLogoutButton)
        )
        exitButton.tintColor = UIColor(resource: .ypRedIOS)
        exitButton.contentMode = .scaleToFill
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(exitButton)
    }
    
    // MARK: - Actions
    @objc
    private func didTapLogoutButton(){
        showExitAllert()
    }
    
    func showExitAllert() {
        let alert = UIAlertController(
            title: "Пока, пока!",
            message: "Уверены, что хотите выйти?",
            preferredStyle: .alert
        )
        let noAction = UIAlertAction(title: "Нет", style: .default)
        let yesAction = UIAlertAction(title: "Да", style: .default) { [weak self] _ in
            guard let self else { return }
            self.profileLogoutService.logout()
            let window = UIApplication.shared.windows.first { $0.isKeyWindow }
            window?.rootViewController = UINavigationController(rootViewController: SplashViewController())
            window?.makeKeyAndVisible()
        }
        alert.addAction(noAction)
        alert.addAction(yesAction)
        present(alert, animated: true)
    }
    
    // MARK: NameLabel Setup
    private func setupNameLabel() {
        nameLabel.text = "Екатерина Новикова"
        nameLabel.textColor = UIColor(resource: .ypWhiteIOS)
        nameLabel.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        nameLabel.contentMode = .left
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
    }
    
    // MARK: - LoginNameLable Setup
    private func setupLoginNameLable() {
        loginNameLable.text = "@ekaterina_nov"
        loginNameLable.textColor = UIColor(resource: .ypGrayIOS)
        loginNameLable.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        loginNameLable.contentMode = .left
        loginNameLable.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginNameLable)
    }
    
    // MARK: - TextLable Setup
    private func setupTextLabel() {
        textLabel.text = "Hello, world!"
        textLabel.textColor = UIColor(resource: .ypWhiteIOS)
        textLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        textLabel.contentMode = .left
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textLabel)
    }
    
    // MARK: - Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            avatarImageView.widthAnchor.constraint(equalToConstant: 70),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            exitButton.heightAnchor.constraint(equalToConstant: 44),
            exitButton.widthAnchor.constraint(equalToConstant: 44),
            exitButton.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            exitButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            nameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 8),
            loginNameLable.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            loginNameLable.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            loginNameLable.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            textLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            textLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            textLabel.topAnchor.constraint(equalTo: loginNameLable.bottomAnchor, constant: 8),
        ])
    }
    
    private func setupObserver() {
        profileImageServiceObserver = NotificationCenter.default
            .addObserver(
                forName: ProfileImageService.didChangeNotification,
                object: nil,
                queue: .main
            ) { [weak self] _ in
                guard let self = self else { return }
                self.updateAvatar()
            }
    }
    
    private func setupUIElements(){
        setupAvatarImageView()
        setupExitButton()
        setupNameLabel()
        setupLoginNameLable()
        setupTextLabel()
        setupConstraints()
    }
    
    private func updateAvatar() {
        guard let profileImageURL = ProfileImageService.shared.avatarURL,
                let url = URL(string: profileImageURL)
        else { return }
        
        avatarImageView.kf.indicatorType = .activity
        avatarImageView.kf.setImage(with: url, placeholder: UIImage(resource: .noAvatar))
    }
    
    private func updateProfileDetails(profile: Profile) {
        nameLabel.text = profile.name.isEmpty
            ? "Имя не указано"
            : profile.name
        loginNameLable.text = profile.loginName.isEmpty
            ? "@неизвестный_пользователь"
            : profile.loginName
        textLabel.text = (profile.bio?.isEmpty ?? true)
            ? "Профиль не заполнен"
            : profile.bio
    }
    
}


