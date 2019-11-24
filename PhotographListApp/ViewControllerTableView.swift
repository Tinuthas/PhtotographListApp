//
//  ViewController.swift
//  PhotographListApp
//
//  Created by Marcus Vinicius Galdino Medeiros on 23/11/19.
//  Copyright © 2019 Marcus Vinicius Galdino Medeiros. All rights reserved.
//

import UIKit


class ViewControllerTableView: UITableViewController {

    private var listPhotograph: [Photograph] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchJsonList{(res) in
            switch res {
            case .success(let photographs):
                photographs.forEach({ (photograph) in
                    print(photograph.author)
                })
                self.listPhotograph = photographs
                self.tableView.reloadData()
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
    
    fileprivate func setImageFromUrl(ImageURL :String, request: @escaping (Data) -> ()) {
       URLSession.shared.dataTask( with: NSURL(string:ImageURL)! as URL, completionHandler: {
          (data, response, error) -> Void in
          DispatchQueue.main.async {
             if let data = data {
                request(data)
             }
        }
       }).resume()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listPhotograph.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
            
        print("Carregando Cell")
        //cell.lazyImageView.image = UIImage(data:listPhotograph[indexPath.row].imageData!)
        setImageFromUrl(ImageURL: listPhotograph[indexPath.row].download_url){(data) in
            cell.lazyImageView.image = UIImage(data: data)
            print("Deu")
        }
        
        cell.lazyTextView.text = listPhotograph[indexPath.row].author
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }

    


}

