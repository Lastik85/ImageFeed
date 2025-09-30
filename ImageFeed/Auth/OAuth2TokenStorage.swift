import UIKit

class OAuth2TokenStorage{
    
    private let key = "bearerToken"
    
    var token: String?{
        get {return UserDefaults.standard.string(forKey: key)}
        set {UserDefaults.standard.set(newValue, forKey: key)}
    }
}
