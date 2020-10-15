//
//  BaseManager.swift
//  CentralTest
//
//  Created by Kent Winder on 10/14/20.
//

import Foundation

class BaseManager {
    public static var shared = BaseManager()
    private let urlSession = URLSession.shared
    
    func request<T: BaseResponse>(withRouter router: BaseRouter, completion: @escaping (Swift.Result<T, BaseError>) -> ()) {
        do {
            let request = try router.asURLRequest()
            let task = urlSession.dataTask(with: request) { (data, response, error) -> Void in
                guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                    completion(.failure(BaseError(message: "Bad response with status code \((response as? HTTPURLResponse)?.statusCode ?? 500)")))
                    return
                }
                
                guard error == nil else {
                    completion(.failure(BaseError(message: error!.localizedDescription)))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(BaseError(message: "No data returned")))
                    return
                }
                
                do {
                    let resultObj = try JSONDecoder().decode(T.self, from: data)
                    if resultObj.status?.lowercased() == "ok" {
                        completion(.success(resultObj))
                    } else {
                        completion(.failure(BaseError(message: resultObj.message ?? "")))
                    }
                } catch {
                    completion(.failure(BaseError(message: "BaseManager: Decode failed")))
                }
            }
            task.resume()
        } catch {
            completion(.failure(BaseError(message: error.localizedDescription)))
        }
    }
}
