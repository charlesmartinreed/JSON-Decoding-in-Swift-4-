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
        let id: Int?
        let name: String?
        let link: String?
        let imageUrl: String?

        //because JSONDecoder is able to automatically match json properties to our properties above, the init is actually extraneous in modern Swift
        
//        init(json: [String: Any]) {
//            id = json["id"] as? Int ?? -1
//            name = json["name"] as? String ?? ""
//            link = json["link"] as? String ?? ""
//            imageUrl = json["imageUrl"] as? String ?? ""
//        }
    }
    
    struct WebsiteDescription: Decodable {
        let name: String
        let description: String
        let courses: [Course]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //for this URL, some of the json categories will be missing. We can handle this by making our data model properties optional.
        let jsonURLString = "https://api.letsbuildthatapp.com/jsondecodable/courses_missing_fields"
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
//                let websiteDescription = try JSONDecoder().decode(WebsiteDescription.self, from: data)
                
                let courses = try JSONDecoder().decode([Course].self, from: data)
                //obviously we'd want to handle the optionality in a more meaningful way here in a production app
                print(courses)
//
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

