//
//  ApiClient.swift
//  NetworkLayer
//
//  Created by Mehdok on 10/29/20.
//

import DomainLayer
import RxSwift

public enum ApiError: MarvelError {
    case invalidResponse(Error)
    case noData(Error)
    case unknown(Error)
    case malformedJson(Error)
    
    public var error: Error {
        switch self {
        case let .invalidResponse(error):
            return error
        case let .noData(error):
            return error
        case let .unknown(error):
            return error
        case let .malformedJson(error):
            return error
        }
    }
}

struct ApiClient: BaseApiClient {
    private let kUrlEndPoint = "https://gateway.marvel.com:443/v1/public/"

    let session: URLSessionProtocol
    let decoder: JSONDecoder
    let keys: Keys

    func call<T>(_ endPoint: EndPoint, headers: [String: String]?, queries: [URLQueryItem]?, body: [String: Any]?) -> Observable<Resource<T>> where T: Decodable, T: Encodable {
        var urlComponenet = URLComponents(string: "\(kUrlEndPoint)/\(endPoint.rawValue)")!
        var finalBody = body ?? [:]
        let request = urlRequest(&urlComponenet,
                                 method: endPoint.method,
                                 headers: headers,
                                 queries: queries,
                                 body: &finalBody)
        
        return Observable.create { subscriber -> Disposable in
            self.session.dataTask(with: request) { data, response, error in
                if let error = error {
                    subscriber.onNext(Resource.error(error: ApiError.unknown(error)))
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse else {
                    subscriber
                        .onNext(Resource.error(error:
                            ApiError.invalidResponse(error ?? NSError(domain: "Server response is invalid.", code: -1))))
                    return
                }

                guard let data = data else {
                    subscriber
                        .onNext(Resource.error(error:
                            ApiError.noData(error ?? NSError(domain: "Server did't returned any data.", code: -1))))
                    return
                }

                do {
                    let statusCode = httpResponse.statusCode
                    if (200 ... 399).contains(statusCode) {
                        let objs = try self.decoder.decode(T.self, from: data)
                        subscriber.onNext(Resource.success(data: objs))
                    } else {
                        subscriber.onError(error ?? NSError(domain: "Server response is invalid.", code: -1))
                    }
                } catch let e {
                    subscriber.onNext(Resource.error(error: ApiError.malformedJson(e)))
                }
            }.resume()
            return Disposables.create()
        }
    }
}

extension ApiClient {
    private func urlRequest(_ component: inout URLComponents,
                            method: String,
                            headers: [String: String]? = nil,
                            queries: [URLQueryItem]? = nil,
                            body: inout [String: Any]) -> URLRequest
    {
        // append client id and secret
        let ts = Date().timeIntervalSince1970

        component.queryItems = [
            URLQueryItem(name: "ts", value: "\(ts)"),
            URLQueryItem(name: "apikey", value: keys.publicKey),
            URLQueryItem(name: "hash", value: "\(ts)\(keys.privateKey)\(keys.publicKey)".md5())
        ]

        // add queries to url
        if let queries = queries {
            queries
                .forEach {
                    component.queryItems?
                        .append(URLQueryItem(name: $0.name, value: $0.value))
                }
        }

        var request = URLRequest(url: component.url!)
        // set http method from endpoint
        request.httpMethod = method

        // add headers
        request.allHTTPHeaderFields = headers

        // add body
        if body.count > 0 {
            do {
                let bodyData = try JSONSerialization
                    .data(withJSONObject: body, options: [])
                request.httpBody = bodyData
            } catch {
                // Log.e(error.localizedDescription)
            }
        }

        return request
    }
}
