//
//  ApiService.swift
//  KasimTurkcellArc
//
//  Created by Sefa Aycicek on 6.11.2024.
//

import UIKit
import RxSwift
import RxAlamofire
import Alamofire

protocol AlamofireApiServiceProtocol {
    func fetchPosts() -> Single<[PostEntity]?>
    func searchMovies(searchText : String) -> Single<MovieResponse?>
}

class AlamofireApiService : AlamofireApiServiceProtocol {
    
    private let manager = HTTPManager.shared
    private let headers : [String : String] = [
        "Content-Type" : "application/json",
        "authorization" : Constants.apiKey
    ]
    private let encoding = JSONEncoding.default
    
    
    func fetchPosts() -> Single<[PostEntity]?> {
        return request(methodType : .get, url: Endpoints.post.asPostUrl)
    }
    
    func searchMovies(searchText: String) -> Single<MovieResponse?> {
        return request(methodType : .get, url: Endpoints.movie.asMovieUrl(query: searchText))
    }
    
    private func request<T: Codable>(methodType : HTTPMethod, url : URL, parameters : [String : AnyObject]? = nil) ->Single<T?> {
        
        
        var httpHeader = HTTPHeaders()
        headers.forEach { (key, value) in
            httpHeader.add(name: key, value: value)
        }
        
        let validateRange = Array(200..<400) + Array(402..<503)
        
        return manager.rx.request(methodType, url, parameters: parameters, encoding: encoding, headers: httpHeader)
            .validate(statusCode: validateRange)
            .responseString()
            .asSingle()
            .catch({ error -> Single<(HTTPURLResponse, String)>  in
                
                
                return Single.error(NSError(domain: "Genel bi hata oluştur", code: 100))
            })
            .flatMap { json -> Single<T?> in
                let jsonString = json.1
                
                guard let data = jsonString.data(using: .utf8) else {
                    return Single.just(nil)
                }
                
                let posts = try? JSONDecoder().decode(T.self, from: data)
                
                return Single.just(posts)
                
            }
    }
    
    final class HTTPManager : Alamofire.Session {
        static let shared : HTTPManager = {
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 30
            configuration.timeoutIntervalForRequest = 30
            
            let manager = HTTPManager(configuration: configuration, interceptor: OAuthHandler())
            return manager
        }()
    }
}



class ApiService: NSObject {
    
    class var shared: ApiService {
        return ApiService()
    }
    
    func fetchPosts(onSuccess : @escaping ([PostEntity])->Void) {
        let urlString = "https://jsonplaceholder.typicode.com/posts"
        guard let url = URL(string: urlString) else  {
            return
        }
       
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        //urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //urlRequest.setValue("Bearer {Token}", forHTTPHeaderField: "Authentication")
        
        URLSession.shared.dataTask(with: urlRequest) { (data, urlResponse, error) in
            if let data = data {
                let json = String(data: data, encoding: .utf8)
                let posts = try? JSONDecoder().decode([PostEntity].self, from: data)
                print(posts)
                
                DispatchQueue.main.async {
                    onSuccess(posts ?? [])
                }
            
            }
        }.resume()
        
        //await ile response alma
       /* //let (data, urlResponse) = try await URLSession.shared.data(for: urlRequest) //(Data, URLResponse)
        let json = String(data: data, encoding: .utf8)
        
        let posts = try? JSONDecoder().decode([Post].self, from: data)
        print(posts)*/
        
        
        
    }
}
