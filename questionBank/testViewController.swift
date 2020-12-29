//
//  testViewController.swift
//  questionBank
//
//  Created by oguz on 23.02.2020.
//  Copyright © 2020 oğuz hendekci. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreData


class testViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var testTableView: UITableView!
    var currentLesson : categoryModel?
    var categoryModels = [categoryModel]()
    var answerModels = [answerModel]()
    var resultModels = [resultModel]()
    var resultArray = [resultModel]()
   

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.currentLesson?.categoryName
        
        testTableView.delegate = self
            testTableView.dataSource = self
            
            
             let parameters: [String: Any] = [
                           
                           "access_key" : "6808",
                           "get_subcategory_by_maincategory" : "1",
                "main_id" : "\(self.currentLesson!.id ?? 0)"]
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
                                category.categoryName = item["subcategory_name"].stringValue
                                category.maxlevel = item["maxlevel"].intValue
                                category.no_of = item["no_of"].intValue
                                category.rowOrder = item["row_order"].intValue
                                self.categoryModels.append(category)
                            }
                            self.testTableView.reloadData()
                          }
                          catch {
                          }
                         
                      case .failure(let error): break
            
            
            
        }
               
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                 
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Questions")
                //request.predicate = NSPredicate(format: "age = %@", "12")
                request.returnsObjectsAsFaults = false
                
                
                
                
                do {
                    let result = try context.fetch(request)
                    for data in result as! [NSManagedObject] {
                        var result = resultModel()
                        result.trueQuestion = (data.value(forKey: "trueQuestion") as! Int)
                        result.emptyQuestion = (data.value(forKey: "emptyQuestion") as! Int)
                        result.falseQuestion = (data.value(forKey: "falseQuestion") as! Int)
                        result.question = (data.value(forKey: "question") as! Int)
                        result.testName = (data.value(forKey: "testName") as! String)
                        result.testId = (data.value(forKey: "testId") as! Int)
                        self.resultArray.append(result)
                  }
                    
                } catch {
                    
                    print("Failed")
                }
        
    }
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         var cell:UITableViewCell = self.testTableView.dequeueReusableCell(withIdentifier: "testTableViewCell") as! UITableViewCell
         cell.detailTextLabel?.text = "Çözülmedi"
        let model : categoryModel
        
        model = categoryModels[indexPath.row]
        
        cell.textLabel?.text = model.categoryName
       var testResult = resultArray.filter { (w) -> Bool in
            return w.testId == model.id!
        }.last
        if testResult != nil {
            cell.detailTextLabel!.text = "\(testResult!.question) Soru - \(testResult!.trueQuestion) Doğru - \(testResult!.falseQuestion) Yanlış - \(testResult!.emptyQuestion) Boş"
        }
        return cell
         
     }
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryModels.count
     
     }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toQuestionView", sender: nil)
         
     }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if (segue.identifier == "toQuestionView") {
        let vc = segue.destination as! QuestionViewController
        vc.currentQuestion = self.categoryModels[self.testTableView.indexPathForSelectedRow?.row ?? 0]
        
        
    }
    


}

}
