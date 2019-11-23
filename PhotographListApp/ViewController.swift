//
//  ViewController.swift
//  PhotographListApp
//
//  Created by Marcus Vinicius Galdino Medeiros on 23/11/19.
//  Copyright © 2019 Marcus Vinicius Galdino Medeiros. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchJsonList{(res) in
            switch res {
            case .success(let photographs):
                photographs.forEach({ (photograph) in
                    print(photograph.author)
                })
            case .failure(let err):
                print("Failed to fetch photographs:", err)
            }
        }
        
//        fetchJsonList{(photographs, err) in
//            if let err = err{
//                print("Failed to fetch photographs:", err)
//                return
//            }
//
//            photographs?.forEach({ (photograph) in
//                print(photograph.author)
//            })
//        }
    }
    
    fileprivate func fetchJsonList(completion: @escaping (Result<[Photograph], Error>) -> ()){
        let urlString = "https://picsum.photos/v2/list?page=2&limit=100"
        
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
                
            if let err = err{
                completion(.failure(err))
                return
            }
            
            do{
                 let photographs = try JSONDecoder().decode([Photograph].self, from: data!)
                completion(.success(photographs))
            }catch let jsonError{
                completion(.failure(jsonError))
            }
           
            
        }.resume()
        
    }


}

