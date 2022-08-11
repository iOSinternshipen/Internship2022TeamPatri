//
//  AuthApiManager.swift
//  Internship2022TeamPatri
//
//  Created by Vlad Silviu Hagiu on 02.08.2022.
//

import Foundation
import FirebaseAuth
import UIKit
import FirebaseFirestore

protocol AuthApiManagerDelegate: AnyObject {
    func didLogIn()
}

class AuthApiManager {
    static let sharedInstance = AuthApiManager()
    private let db = Firestore.firestore()
    public var isLoggedIn: Bool = false
    weak var delegate : AuthApiManagerDelegate?
    
    func loginAPI(email: String?, password: String?, completion:  @escaping (Error?) -> Void) {
        FirebaseAuth.Auth.auth().signIn(withEmail: email ?? "default", password: password ?? "default", completion: { result, error in
            if error != nil  {
                self.isLoggedIn = false
                print(error!.localizedDescription)
            } else {
                self.isLoggedIn = true
                print("Succesfully logged in")
                self.delegate?.didLogIn()
            }
            completion(error)
        })
    }
    func logOut() {
        do {
            try Auth.auth().signOut()
            isLoggedIn = false
            let userIsLoggedOut = AppDelegate()
            userIsLoggedOut.resetRoot()
            print("Succesfully logged out")
        } catch let logOutError {
            print(logOutError)
        }
    }
}
