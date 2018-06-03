//
//  LoginViewModel.swift
//  ViewingOnlineDatabases
//
//  Created by Stanislau on 30.05.2018.
//  Copyright © 2018 Stanislau. All rights reserved.
//

import Foundation

class LoginViewModel {
    var status = ""
    var login = ""
    var password = ""
    
    func userValidation(success: @escaping () -> Void, unsuccess: @escaping () -> Void) {
        guard let url = URL(string: "http://condor.alarstudios.com/test/auth.cgi?username=\(login)&password=\(password)") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let responseFromServer = try JSONDecoder().decode(ValidationAttributes.self, from: data)
                self.status = responseFromServer.status
                UserDefaults.standard.set(responseFromServer.code, forKey: "code")
                DispatchQueue.main.async {
                    if self.status == "ok" {
                        success()
                    } else {
                        unsuccess()
                    } 
                }
            } catch {
                print(error.localizedDescription)
            }
            }.resume()
    }
}
