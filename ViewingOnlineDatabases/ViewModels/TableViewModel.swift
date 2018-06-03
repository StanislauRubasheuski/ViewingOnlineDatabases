//
//  TableViewModel.swift
//  ViewingOnlineDatabases
//
//  Created by Stanislau on 30.05.2018.
//  Copyright © 2018 Stanislau. All rights reserved.
//

import Foundation
import UIKit

class TableViewModel {
    let code = UserDefaults.standard.value(forKey: "code")
    var dataSource = [DataAttributes]()
    var page = 0
    var image: UIImage!
    
    func numberOfRowsInSection() -> Int {
        return dataSource.count
    }
    
    func fetchData(completion: @escaping () -> Void) {
        page += 1
        print(page)
        guard let code = code else { return }
        guard let url = URL(string: "http://condor.alarstudios.com/test/data.cgi?code=\(code)&p=\(String(page))") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let sortedData = try JSONDecoder().decode(DescriptionAttributes.self, from: data)
                for dict in sortedData.data {
                    self.dataSource.append(dict)
                }
                DispatchQueue.main.async {
                    completion()
                }
                
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func downloadIMG(completion: @escaping () -> Void) {
        guard let url = URL(string: "https://mirpozitiva.ru/uploads/posts/2016-09/medium/1474011210_15.jpg") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            self.image = UIImage(data: data)
            DispatchQueue.main.async {
                completion()
            }
        }.resume()
    }
}
