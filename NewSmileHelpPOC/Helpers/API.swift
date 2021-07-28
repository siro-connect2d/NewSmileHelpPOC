//
//  API.swift
//  NewSmileHS
//
//  Created by thang on 23/07/2021.
//

import UIKit
import Alamofire

class API:NSObject {

    static public func callAPI(ApiMethod : HTTPMethod ,forURL:String,parameters:[String:Any]?,completion: @escaping (_ success : Bool,_ responseData : Any?,_ error : String?)->Void){
        
        if !Utility.hasConnection() {
            let alertController = UIAlertController(title: "No internet connection", message: "Please connect to the network", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Retry", style: .default) { (action) in
                //On retry call API again
                self.callAPI(ApiMethod: ApiMethod, forURL: forURL, parameters: parameters) { (success, data, error) in
                    completion(success, data, error)
                }
            }
            alertController.addAction(alertAction)
            if let vc = UIApplication.topController() {
                if vc.navigationController == nil{
                    completion(false,nil,"No internet connection")
                    return
                }
                vc.navigationController?.present(alertController, animated: true, completion: nil)
            } else {
                completion(false,nil,"No internet connection")
            }
            return
        }
        
        var headers: HTTPHeaders {
            get {
                return  ["Accept": "application/json"]
            }
        }
        
        AF.request(forURL, method: ApiMethod, parameters: parameters, encoding: URLEncoding.default, headers: headers).response { response in
            switch response.result {
            case let .success(data):
                let jsonDecoder = JSONDecoder()
                if let data = data {
                    if let errorCheck = try? jsonDecoder.decode(Post.self, from: data) {
                        if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                            do {
                                let reponseDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                
                                let error : String = reponseDict?["error"] as? String ?? "Something went wrong."
                                
                                completion(errorCheck.status == 200,data, error=="" ? nil : error)
                                //if token is invalid back to login screen
//                                if(errorCheck.status == 401 && !isLoginAPI)
//                                {
//                                    KeychainSwift().set("", forKey: "authToken")
//                                    KeychainSwift().set("0", forKey: "userType")
//
//                                    let vc = Storyboards.landingPage.instantiate() as! WelcomeViewController
//                                    let navController = UINavigationController(rootViewController: vc)
//                                    navController.modalPresentationStyle = .fullScreen
//                                    navController.navigationBar.isHidden = true
//                                    SceneDelegate.shared.window?.rootViewController = navController
//                                }
                            } catch {
                                print(error.localizedDescription)
                                completion(errorCheck.status == 200,data, error.localizedDescription)
                            }
                            #if DEBUG
                            print("Data: \(utf8Text)")
                            #endif
                        } else {
                            completion(false,nil,"something went wrong")
                        }
                    } else {
                        completion(false,nil,"something went wrong")
                    }
                } else {
                    print("Error")
                    completion(false,nil,"something went wrong")
                }
            case let .failure(error):
                print(error)
                completion(false,nil,"something went wrong")
            }
        }
    }
}
