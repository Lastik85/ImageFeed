import UIKit

class OAuth2TokenStorage{
    
    static let shared = OAuth2TokenStorage()
    private init() {}
    
    private let key = "Bearer"
    
    var authtoken: String?{
        get {return UserDefaults.standard.string(forKey: key)}
        set {UserDefaults.standard.set(newValue, forKey: key)}
    }
}
