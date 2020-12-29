//
//  myAnsweredViewController.swift
//  questionBank
//
//  Created by oguz on 2.05.2020.
//  Copyright © 2020 oğuz hendekci. All rights reserved.
//

import UIKit
import CoreData

class myAnsweredViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var answerModels = [answerModel]()
    var currentQuestion : categoryModel?
    var categoryModels = [categoryModel]()
    var nameArray = [String]()
    var idArray = [UUID]()
    
    @IBOutlet weak var myAnsweredTableView: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myAnsweredTableView.delegate = self
        myAnsweredTableView.dataSource = self

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.myAnsweredTableView.dequeueReusableCell(withIdentifier: "myAnsweredTableViewCell")!
         
        let model : answerModel
        
        model = self.answerModels[indexPath.row]
        
        cell.textLabel?.text = "\(indexPath.row + 1). Soru"
        cell.textLabel!.textColor = UIColor.white
        if model.myAnswer == ""{
            cell.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }else if model.myAnswer == model.answer{
            cell.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            
        }else{
            cell.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
            
        }
        cell.detailTextLabel!.text = "cevabınız : \(model.myAnswer!) doğru cevap : \(model.answer!)  "
        cell.detailTextLabel!.textColor = UIColor.white
         return cell
         
     }
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answerModels.count
     
     }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
     }
}
