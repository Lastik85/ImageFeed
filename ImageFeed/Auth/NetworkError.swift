import UIKit

enum NetworkError: Error {
    case httpStatusCode(Int)
    case urlRequestError(Error)
    case urlSessionError
    case invalidRequest
    case decodingError(Error)
}

enum AuthServiceError: Error {
    case invalidRequest
}

enum HttpMethods {
    static let get = "GET"
    static let post = "POST"
    static let delete = "DELETE"
}
