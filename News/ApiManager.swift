//
//  ApiManager.swift
//  Questionare App
//
//  Created by Salman on 12/26/17.
//  Copyright © 2017 antzion. All rights reserved.
//

import UIKit

class ApiManager{
    
    private static let Api_Key = "4f3678e753a046af97cc99d9029ddd77"
    typealias RegisterUserWithCallback = (Error?, Data?)-> Void
    
    
    
    static func sendGetRequest(url: String, completion: @escaping RegisterUserWithCallback){
        let urlAdress = url
        print(urlAdress)
        if let url: URL = URL(string: urlAdress){
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                print(response)
                if let error = error{
                    completion(error, nil)
                }
                else{
                    if let data = data{
                        completion(nil, data)
                    }
                }
            }).resume()
            
        }
    }
    
}
