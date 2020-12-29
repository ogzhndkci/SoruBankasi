//
//  loginViewController.swift
//  questionBank
//
//  Created by oguz on 11.01.2020.
//  Copyright © 2020 oğuz hendekci. All rights reserved.
//

import UIKit
import Firebase
import Alamofire
import SwiftyJSON
import CoreData

class loginViewController: UIViewController {

   
    @IBOutlet weak var loginPasswordTextfield: UITextField!
    @IBOutlet weak var loginEmailTextfield: UITextField!
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    @IBAction func loginButton(_ sender: Any) {
        
        
        
        
        
        if loginEmailTextfield.text != "" && loginPasswordTextfield.text != "" {
            let parameters: [String: Any] = [
                "user_signup" : "1",
                "access_key" : "6808",
                "name" : loginEmailTextfield.text!,
                "email" : loginPasswordTextfield.text!,
                "mobile" : "12312839879",
                "type" : "email",
                "ip_address" : self.getIPAddress(),
                "status" : "1",
                "fcm_id" : "asd123asd"
                
            ]
            

           AF.request("https://cagrican.com/kpss/api-v2.php", method: .post, parameters: parameters).response {
            
            response in
            switch response.result {

            case .success(let responseData):
                do{
                    let responseJson = try JSON(data: responseData!)
                        
                }
                catch {
                }
               
            case .failure(let error): break
            
            }
            self.performSegue(withIdentifier: "loginToVC", sender: nil)
            
           
            
        }
  
    
        }else{
            makeAlert(titleInput: "wrong", messageInput: "yanlış yaptın bro")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        loginButton.backgroundColor = UIColor.clear
        loginButton.layer.cornerRadius = 18
        loginButton.layer.borderWidth = 2
        loginButton.layer.borderColor = #colorLiteral(red: 0.8304449556, green: 0.4671033306, blue: 0.00510714228, alpha: 1)
        loginButton.layer.backgroundColor = #colorLiteral(red: 0.8304449556, green: 0.4671033306, blue: 0.00510714228, alpha: 1)
        
        
        
        loginPasswordTextfield.isSecureTextEntry = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)

        // Do any additional setup after loading the view.
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
   
    
    
    func makeAlert(titleInput:String, messageInput:String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func getIPAddress() -> String {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next }

                let interface = ptr?.pointee
                let addrFamily = interface?.ifa_addr.pointee.sa_family
                if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {

                    // wifi = ["en0"]
                    // wired = ["en2", "en3", "en4"]
                    // cellular = ["pdp_ip0","pdp_ip1","pdp_ip2","pdp_ip3"]

                    let name: String = String(cString: (interface!.ifa_name))
                    if  name == "en0" || name == "en2" || name == "en3" || name == "en4" || name == "pdp_ip0" || name == "pdp_ip1" || name == "pdp_ip2" || name == "pdp_ip3" {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        getnameinfo(interface?.ifa_addr, socklen_t((interface?.ifa_addr.pointee.sa_len)!), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
                        address = String(cString: hostname)
                    }
                }
            }
            freeifaddrs(ifaddr)
        }
        return address ?? ""
    }
    

    

}
