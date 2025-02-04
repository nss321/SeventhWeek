//
//  NetworkManager.swift
//  SeventhWeek
//
//  Created by BAE on 2/3/25.
//

import UIKit
import Alamofire

struct Lotto: Decodable {
    let drwNo1: String
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    
    // 1. 원본
    func getLotto(successHandler: @escaping (Lotto) -> Void,
                        failHandler: @escaping () -> Void) {
        
        AF.request("https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1154")
            .validate(statusCode: 200..<500)
//            .responseString(completionHandler: { value in
//                dump(value)
//            })
            .responseDecodable(of: Lotto.self) { response in
                switch response.result {
                case .success(let value):
                    print(value)
                    successHandler(value)
                case .failure(let error):
                    print(error)
                    failHandler()
                }
            }
    }
    
    
    // 2. 컴플리션 통합
    func getLotto(completionHandler: @escaping (Lotto?, AFError?) -> Void) {
        
        AF.request("https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1154")
            .validate(statusCode: 200..<500)
//            .responseString(completionHandler: { value in
//                dump(value)
//            })
            .responseDecodable(of: Lotto.self) { response in
                switch response.result {
                case .success(let value):
                    print(value)
                    completionHandler(value, nil)
                case .failure(let error):
                    print(error)
                    completionHandler(nil, error)
                }
            }
    }
    
    // 3.
    func getLotto(completionHandler: @escaping (Result<Lotto, AFError>) -> Void) {
        
        AF.request("https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1154")
            .validate(statusCode: 200..<500)
//            .responseString(completionHandler: { value in
//                dump(value)
//            })
            .responseDecodable(of: Lotto.self) { response in
                switch response.result {
                case .success(let value):
                    print(value)
                    completionHandler(.success(value))
                case .failure(let error):
                    print(error)
                      completionHandler(.failure(error))
                }
            }
    }
    
    
    
    
}

