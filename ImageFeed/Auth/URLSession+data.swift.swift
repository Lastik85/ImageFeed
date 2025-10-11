import UIKit

extension URLSession {
    func data(for request: URLRequest,completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionTask {
        let fulfillCompletionOnTheMainThread: (Result<Data, Error>) -> Void = {
            result in
            DispatchQueue.main.async {
                completion(result)
            }
        }

        let task = dataTask(
            with: request,
            completionHandler: { data, response, error in
                if let data = data, let response = response,
                    let statusCode = (response as? HTTPURLResponse)?.statusCode
                {
                    if 200..<300 ~= statusCode {
                        fulfillCompletionOnTheMainThread(.success(data))
                    } else {
                        print("[dataTask] invalid status code: \(statusCode)")
                        fulfillCompletionOnTheMainThread(
                            .failure(NetworkError.httpStatusCode(statusCode))
                        )
                    }
                } else if let error = error {
                    print("[dataTask]: URLRequestError: \(error)")
                    fulfillCompletionOnTheMainThread(
                        .failure(NetworkError.urlRequestError(error))
                    )
                } else {
                    print("[dataTask]: URLSessionError")
                    fulfillCompletionOnTheMainThread(
                        .failure(NetworkError.urlSessionError)
                    )
                }
            }
        )
        return task
    }
}

extension URLSession {
    func objectTask<T: Decodable>(for request: URLRequest,completion: @escaping (Result<T, Error>) -> Void) ->URLSessionTask {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase 

        let task = data(for: request) { (result: Result<Data, Error>) in
            switch result {
            case .success(let data):

                do {
                    let decodedObject = try decoder.decode(T.self, from: data)
                    completion(.success(decodedObject))
                } catch {
                    if let decodingError = error as? DecodingError {
                        print("[URLession.objectTask]: decoding error - \(decodingError), Данные: \(String(data: data, encoding: .utf8) ?? "")")
                    } else {
                        print("[URLession.objectTask]: decoding error - \(error.localizedDescription), Данные: \(String(data: data, encoding: .utf8) ?? "")")
                    }
                    completion(.failure(error))
                }

            case .failure(let error):
                print("URLession.objectTask]: - \(error.localizedDescription)")
                completion(.failure(error))
            }
        }

        return task
    }
}
