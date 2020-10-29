//
//  URLSessionImpl.swift
//  NetworkLayer
//
//  Created by Mehdok on 10/29/20.
//

import UIKit

struct URLSessionImpl: URLSessionProtocol {
    let session: URLSession

    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        session.dataTask(with: request, completionHandler: completionHandler)
    }
}
