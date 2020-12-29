//
//  LessonsViewController.swift
//  questionBank
//
//  Created by oguz on 2.02.2020.
//  Copyright © 2020 oğuz hendekci. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LessonsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var lessonsTableView: UITableView!
    
    var categoryModels = [categoryModel]()
    var lessonsList = [String]()
    var currentExam = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lessonsTableView.delegate = self
        lessonsTableView.dataSource = self
        
        
         let parameters: [String: Any] = [
                       
                       "access_key" : "6808",
                       "get_categories" : "1" ,
                       "exam" : currentExam
        ]
        AF.request("https://cagrican.com/kpss/api-v2.php", method: .post, parameters: parameters).response {
                  
                  response in
                  switch response.result {

                  case .success(let responseData):
                      do{
                          let responseJson = try JSON(data: responseData!)
                        for item in responseJson["data"].arrayValue {
                            print(item["id"].stringValue)
                           var category = categoryModel()
                            category.id = item["id"].intValue
                            category.categoryName = item["category_name"].stringValue
                            category.maxlevel = item["maxlevel"].intValue
                            category.no_of = item["no_of"].intValue
                            category.rowOrder = item["row_order"].intValue
                            self.categoryModels.append(category)
                        }
                        self.lessonsTableView.reloadData()
                      }
                      catch {
                      }
                     
                  case .failure(let error): break
        
        
        
    }
    
        }
    
}
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         var cell:UITableViewCell = self.lessonsTableView.dequeueReusableCell(withIdentifier: "lessonsTableViewCell") as! UITableViewCell
         
        let model : categoryModel
        
        model = categoryModels[indexPath.row]
        
        cell.textLabel?.text = model.categoryName
        cell.detailTextLabel!.text = "\(model.no_of!) deneme"
         return cell
         
     }
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryModels.count
     
     }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         performSegue(withIdentifier: "toTestView", sender: nil)
     }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toTestView") {
            let vc = segue.destination as! testViewController
            vc.currentLesson = self.categoryModels[self.lessonsTableView.indexPathForSelectedRow?.row ?? 0]
        }
        
    }
     
}
