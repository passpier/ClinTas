//
//  ApiManager.swift
//  ClinTas
//
//  Created by ping sheng cheng on 2019/2/28.
//  Copyright © 2019 ping sheng cheng. All rights reserved.
//

import Alamofire

class ApiManager {
    
    typealias completed = (_ placeHolders: Array<PlaceHolder>) -> Void
    typealias failed = () -> Void
    
    static func fetchPlaceHolders(completeHandler: @escaping completed, failHandler: @escaping failed) {
        Alamofire.request("https://jsonplaceholder.typicode.com/photos")
            .validate()
            .responseJSON
            { response in
                switch response.result {
                case .success(let value):
                    print("Validation Successful")
                    var placeHolders = Array<PlaceHolder>()
                    for item in (value as? [[String: Any]])! {
                        let placeHolder = PlaceHolder(id: item["id"] as! Int, title: item["title"] as! String, thumbnailUrl: item["thumbnailUrl"] as! String)
                        placeHolders.append(placeHolder)
                    }
                    completeHandler(placeHolders)
                case .failure(let error):
                    print("error\(error)")
                    failHandler()
                }
        }
    }
}
