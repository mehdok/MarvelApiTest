//
//  ApiClientMock.swift
//  NetworkLayerTests
//
//  Created by Mehdok on 10/31/20.
//

@testable import NetworkLayer
import DomainLayer
import RxSwift

class ApiClientMock: BaseApiClient {
    func call<T: Decodable>(_ endPoint: EndPoint,
                            headers: [String: String]?,
                            queries: [URLQueryItem]?,
                            body: [String: Any]?) -> Observable<Resource<T>> {
        return Observable.create { subscriber -> Disposable in
            if let jsonData = self.jsonData(name: endPoint.mockJsonFile) {
                do {
                    let objs = try JSONDecoder().decode(T.self, from: jsonData)
                    subscriber.onNext(Resource.success(data: objs))
                } catch let e {
                    subscriber.onNext(Resource.error(error: ApiError.unknown(e)))
                }
            } else {
                subscriber
                    .onNext(Resource.error(error:
                        ApiError.noData(NSError(domain: "can not find mock data", code: -1))))
            }
            return Disposables.create()
        }
    }
}

extension ApiClientMock {
    fileprivate func jsonData(name: String) -> Data? {
        guard let filepath = Bundle(for: ApiClientMock.self)
            .url(forResource: name, withExtension: "json") else {
            return nil
        }

        do {
            let contents = try Data(contentsOf: filepath)
            return contents
        } catch {
            return nil
        }
    }
}
