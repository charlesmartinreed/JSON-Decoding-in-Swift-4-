//
//  ViewController.swift
//  JSON Decoding in Swift 4+
//
//  Created by Charles Martin Reed on 1/23/19.
//  Copyright © 2019 Charles Martin Reed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    struct Course: Decodable {
        let id: Int
        let name: String
        let link: String
        let imageUrl: String
        
        init(json: [String: Any]) {
            id = json["id"] as? Int ?? -1
            name = json["name"] as? String ?? ""
            link = json["link"] as? String ?? ""
            imageUrl = json["imageUrl"] as? String ?? ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let jsonURLString = "https://api.letsbuildthatapp.com/jsondecodable/course"
        guard let url = URL(string: jsonURLString) else { return }
        fetchJSONData(for: url)
    
    }
    
    func fetchJSONData(for url: URL) {
        //execute a URL session
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            //check error
            //check response is 200/OK
            guard let data = data else { return }
//            let stringFromData = String(data: data, encoding: .utf8)
            
            //Swift 4+ means - make sure your data model conforms to Decodable
            do {
                let course = try JSONDecoder().decode(Course.self, from: data)
                print(course.name)
                
                // serializing data in the old, pre Swift-4 ways - Swift 2/3/Obj-C
                // guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any] else { fatalError("Could not retrieve json data")}
//                let course = Course(json: json)
//                print(course.name)
            } catch let jsonErr {
                print("Error with serialization of JSON data", jsonErr)
            }
        }.resume()
    }


}

