//
//  Network.swift
//  NetworkPlatform
//
//  Created by 이동영 on 2020/01/21.
//  Copyright © 2020 이동영. All rights reserved.
//

import Foundation
import Domain
import Alamofire

open class Network {
    private let baseURL = URL(string: "https://openapi.naver.com/v1/search/book.json")!
    private let clientID = "TTp6JTvDdd6eeEXvko0z"
    private let clientSecret = "38j0sz_T8N"
    
    static let `default` = Network()
    
    func request(with query: String, completion: @escaping (Swift.Result<[Book], Swift.Error>) -> Void) {
        do {
            let request = try makeRequest(with: query)
            request?.responseData { response in
                guard let data = response.data else {
                    completion(.failure(Network.Error.notResponse))
                    return
                }
                
                guard let response = try? JSONDecoder().decode(Network.Response.self, from: data) else {
                    completion(.failure(Network.Error.badResponse))
                    return
                }
                
                completion(.success(response.items))
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    func save(book: Book, completion: @escaping (Swift.Result<Void, Error>) -> Void) {
        ()
    }
    
    func delete(completion: @escaping (Swift.Result<Void, Error>) -> Void) {
        ()
    }
    
    private func makeRequest(with query: String) throws -> DataRequest? {
        let headers: HTTPHeaders = ["X-Naver-Client-Id": clientID,
                                    "X-Naver-Client-Secret": clientSecret]
        let parameter: Parameters = ["query": query]
        
        return AF.request(baseURL,
                          method: .get,
                          parameters: parameter,
                          headers: headers)
    }
    
    enum Error: LocalizedError {
        case notResponse
        case badResponse
        
        var errorDescription: String? {
            switch self {
            case .notResponse:
                return "서버로 부터 응답이 없습니다."
            case .badResponse:
                return "서버로 부터 온 데이터가 올바르지 않습니다."
            }
        }
    }
}


