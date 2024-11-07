//
//  OAuthHandler.swift
//  KasimTurkcellArc
//
//  Created by Sefa Aycicek on 6.11.2024.
//

import UIKit
import RxAlamofire
import Alamofire

class OAuthHandler: RequestInterceptor {

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
        var mutableRequest = urlRequest
        mutableRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        mutableRequest.setValue(Constants.apiKey, forHTTPHeaderField: "authorization")
        
        completion(.success(mutableRequest))
    }
    
    let retryLimit = 2
    func retry(_ request: Request, for session: Session, dueTo error: any Error, completion: @escaping (RetryResult) -> Void) {
        guard let status = request.response?.statusCode else {
            completion(.doNotRetry)
            return
        }
        
        guard request.retryCount < retryLimit else {
            completion(.doNotRetry)
            return
        }
        
        if status == 401 {
            // refresh token
            Constants.apiKey = "apikey 5IlsFwtkraxsj2NtgYY4sS:7CfJyGGSTlxLJWAEXmIbfz"
            completion(.retry)
        } else {
            completion(.doNotRetry)
        }
    }
}
