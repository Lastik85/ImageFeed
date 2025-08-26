import UIKit

final class ProfileViewController: UIViewController {
    
    private var photoImage = UIImage()
    private var avatarImageView = UIImageView()
    private var exitButton = UIButton()
    private let nameLabel = UILabel()
    private let loginNameLable = UILabel()
    private let textLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupImageView()
        setupLogoutButton()
        setupNameLabel()
        setupNicknameLabel()
        setupTextLabel()
        setupConstraints()
    }
    
    private func setupView() {
        view.contentMode = .scaleToFill
        view.backgroundColor = UIColor(named: "YP Black (iOS)")
    }
    
    private func setupImageView() {
        photoImage = UIImage(named: "avatar")!
        avatarImageView = UIImageView(image: photoImage)
        avatarImageView.layer.masksToBounds = false
        avatarImageView.layer.cornerRadius = 35
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(avatarImageView)
    }
    
    private func setupLogoutButton() {
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
    
    @objc
    private func didTapLogoutButton(){}
    
    private func setupNameLabel() {
        nameLabel.text = "Екатерина Новикова"
        nameLabel.textColor = UIColor(named: "YP White (iOS)")
        nameLabel.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        nameLabel.contentMode = .left
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
    }
    
    private func setupNicknameLabel() {
        loginNameLable.text = "@ekaterina_nov"
        loginNameLable.textColor = UIColor(named: "YP Gray (iOS)")
        loginNameLable.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        loginNameLable.contentMode = .left
        loginNameLable.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginNameLable)
    }
    
    private func setupTextLabel() {
        textLabel.text = "Hello, world!"
        textLabel.textColor = UIColor(named: "YP White (iOS)")
        textLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        textLabel.contentMode = .left
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textLabel)
    }
    
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
    
}


