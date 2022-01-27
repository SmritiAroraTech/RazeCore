//
//  Networking.swift
//  RazeCore
//
//  Created by Nineleaps on 27/02/21.
//

import Foundation

public protocol NetworkSession {
    func get(from url: URL, completionHandler: @escaping (Data?,Error?) -> Void )
    func post(with url: URL, completionHandler: @escaping (Data?,Error?) -> Void )
}

extension URLSession: NetworkSession {
    public func get(from url: URL, completionHandler: @escaping (Data?, Error?) -> Void) {
        let task = dataTask(with: url) { data, _, error in
            completionHandler(data, error)
        }
        task.resume()
    }
    
    public func post(with url: URL, completionHandler: @escaping (Data?, Error?) -> Void) {
        let task = dataTask(with: url) { data, _, error in
            completionHandler(data, error)
        }
        task.resume()
    }
}

extension RazeCore {
    public class Networking {
        /// This class will handle all network calls
        /// - Warning : Must be created before using any public APIs
        public class Manager {
            public init() { }
            
            internal var session : NetworkSession = URLSession.shared
            
            /// Calls internet to get data to the app
            /// - Parameters:
            ///   - url: the place where the data resides
            ///   - completionHandler: Returns the result object
            public func loadData(from url: URL, completionHandler: @escaping (NetworkResult<Data>) -> Void ) {
                session.get(from: url) { (data, error) in
                    let result = data.map(NetworkResult<Data>.success) ?? .failure(error)
                    completionHandler(result)
                }
            }
            
            /// Sends data to url
            /// - Parameters:
            ///   - url: the place where the data is to be sent
            ///   - body: the object intended to send
            ///   - completionHandler: Returns the result object
            public func sendData<I: Codable>(to url: URL, body: I, completionHandler: @escaping (NetworkResult<Data>) -> Void ) {
                session.get(from: url) { (data, error) in
                    var request = URLRequest(url: url)
                    do {
                        let httpBody = try JSONEncoder().encode(data)
                        request.httpBody = httpBody
                        request.httpMethod = "POST"
                        self.session.post(with: url) { (data, error) in
                            let result = data.map(NetworkResult<Data>.success) ?? .failure(error)
                            completionHandler(result)
                        }
                    } catch let error{
                        return completionHandler(.failure(error))
                    }
                    
                }
            }
        }
        public enum NetworkResult<Value> {
            case success(Value)
            case failure(Error?)
        }
    }
}
