//
//  MainVC.swift
//  NewSmileHS
//
//  Created by thang on 23/07/2021.
//

import UIKit
import SafariServices

class MainVC: UIViewController {

    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSupport: UIButton!
    @IBOutlet weak var lblStatus: UILabel!
    
    var userInfo = UserLoginCredentialModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        btnLogin.layer.cornerRadius = 10
        btnLogin.clipsToBounds = true
        btnSupport.layer.cornerRadius = 10
        btnSupport.clipsToBounds = true
        
        self.lblStatus.text = ""
        tfUsername.delegate = self
        tfPassword.delegate = self
    }

    @IBAction func onLogin(_ sender: UIButton) {
        self.lblStatus.text = ""
        if let username = tfUsername.text,let password = tfPassword.text {
            Utility.showHUD(in: view)
            let parameters = ["email": username,"password": password,"platform":"ios"] as [String:Any]
            API.callAPI(ApiMethod: .post, forURL: patientLogin, parameters: parameters) { (success, data,error) in
                Utility.hideHUD(in: self.view)
                if !success || data == nil || error != nil{
                    self.lblStatus.text = error
                    return
                }
                let jsonDecoder = JSONDecoder()
                if let patientLogin = try? jsonDecoder.decode(PatientLoginRegisterModel.self, from: data! as! Data) {
                    self.userInfo.email = username
                    self.userInfo.password = password
                    self.userInfo.loginMethod = LoginMethod.email.rawValue
                    self.userInfo.accessToken = patientLogin.data?.token
                    self.lblStatus.text = "User successfully logged in"
                } else {
                    self.lblStatus.text = "Failed to login"
                }
            }
        }
    }
    
    @IBAction func onClick(_ sender: UIButton) {
        guard let accessToken = userInfo.accessToken else {
            let alertController = UIAlertController(title: nil, message: "Please login to continue", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(alertAction)
            DispatchQueue.main.async {
                self.present(alertController, animated: true, completion: nil)
            }
            return
        }
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "HelpAndSupportVC") as! HelpAndSupportVC
        vc.accessToken = accessToken
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textfield: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
