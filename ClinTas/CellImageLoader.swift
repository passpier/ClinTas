//
//  CellImageLoader.swift
//  ClinTas
//
//  Created by ping sheng cheng on 2019/2/28.
//  Copyright © 2019 ping sheng cheng. All rights reserved.
//

import UIKit
import Alamofire

class CellImageLoader {
    
    typealias completed = (_ image: UIImage) -> Void
    
    private var thumbnailUrl: String
    private var imageRequest: DataRequest?
    
    init(url: String) {
        self.thumbnailUrl = url
    }
    
    func fetchImage(completionHandler: @escaping completed) {
        imageRequest = Alamofire.request(thumbnailUrl)
            .responseData{response in
                if let data = response.result.value {
                    completionHandler(UIImage(data: data)!)
                }
        }
    }
    
    func suspend() {
        imageRequest?.suspend()
    }
    
    func resume() {
        imageRequest?.resume()
    }

}
