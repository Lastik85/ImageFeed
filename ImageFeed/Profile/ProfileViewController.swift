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
        view.backgroundColor = UIColor(named: "YP Black (iOS)")
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
            with: UIImage(named: "Logout")!,
            target: self,
            action: #selector(didTapLogoutButton)
        )
        exitButton.tintColor = UIColor(named: "YP Red (iOS)")
        exitButton.contentMode = .scaleToFill
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(exitButton)
    }
    
    // MARK: - Actions
    @objc
    private func didTapLogoutButton(){}
    
    // MARK: NameLabel Setup
    private func setupNameLabel() {
        nameLabel.text = "Екатерина Новикова"
        nameLabel.textColor = UIColor(named: "YP White (iOS)")
        nameLabel.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        nameLabel.contentMode = .left
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
    }
    
    // MARK: - LoginNameLable Setup
    private func setupLoginNameLable() {
        loginNameLable.text = "@ekaterina_nov"
        loginNameLable.textColor = UIColor(named: "YP Gray (iOS)")
        loginNameLable.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        loginNameLable.contentMode = .left
        loginNameLable.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginNameLable)
    }
    
    // MARK: - TextLable Setup
    private func setupTextLabel() {
        textLabel.text = "Hello, world!"
        textLabel.textColor = UIColor(named: "YP White (iOS)")
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
        else {
            return
        }
        
        avatarImageView.kf.indicatorType = .activity
        avatarImageView.kf.setImage(
                    with: url,
                    placeholder: UIImage(named: "noAvatar")
                )
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


