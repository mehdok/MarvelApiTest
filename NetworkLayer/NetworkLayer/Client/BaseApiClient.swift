//
//  BaseApiClient.swift
//  NetworkLayer
//
//  Created by Mehdok on 10/29/20.
//

import DomainLayer
import RxSwift

protocol BaseApiClient {
    /// Call the api for specific data
    /// - Parameters:
    ///   - endPoint: The endpoint to call
    ///   - headers: headers for api call
    ///   - queries: queries param for api call
    ///   - body: body for post requests
    /// - Returns: An observable of Resource of decodable T
    func call<T: Decodable>(_ endPoint: EndPoint,
                            headers: [String: String]?,
                            queries: [URLQueryItem]?,
                            body: [String: Any]?) -> Observable<Resource<T>>
}
