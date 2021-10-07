//
//  Network.swift
//  CombinePOC
//
//  Created by ANGEL on 29/09/21.
//

import Foundation
import Combine

protocol NetworkProtocol: AnyObject {
    typealias Headers = [String: Any]

    func get<T>(type: T.Type,
                url: URL,
                headers: Headers) -> AnyPublisher<T, Error> where T: Decodable // We could create two like this for the GraphQL Classes

    func getData(url: URL, headers: Headers) -> AnyPublisher<Data, URLError>
}

final class Network: NetworkProtocol {

    func get<T>(type: T.Type,
                url: URL,
                headers: Headers) -> AnyPublisher<T, Error> where T : Decodable {

        var urlRequest = URLRequest(url: url)

        headers.forEach { key, value in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }

        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    func getData(url: URL, headers: Headers) -> AnyPublisher<Data, URLError> {

        var urlRequest = URLRequest(url: url)

        headers.forEach { key, value in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }

        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .eraseToAnyPublisher()
    }
}
