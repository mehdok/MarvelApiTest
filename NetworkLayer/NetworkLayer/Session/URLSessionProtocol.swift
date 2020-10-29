//
//  URLSessionProtocol.swift
//  NetworkLayer
//
//  Created by Mehdok on 10/29/20.
//

import UIKit

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}
