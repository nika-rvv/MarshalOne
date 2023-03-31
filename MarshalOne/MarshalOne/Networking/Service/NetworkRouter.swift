//
//  NetworkRouter.swift
//  MarshalOne
//
//  Created by Veronika on 25.03.2023.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

protocol NetworkRouter: AnyObject {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint) async -> (data: Data?, response: URLResponse?, error: Error?)
    func cancel(index: Int)
    func cancelAll()
}
