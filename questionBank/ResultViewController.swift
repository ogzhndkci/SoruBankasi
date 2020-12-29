//
//  ResultViewController.swift
//  questionBank
//
//  Created by oguz on 16.03.2020.
//  Copyright © 2020 oğuz hendekci. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import WebKit
import CoreData

class ResultViewController: UIViewController {
    var answerModels = [answerModel]()
    var currentQuestion : categoryModel?
    @IBOutlet weak var questionCount: UILabel!
    @IBOutlet weak var trueCount: UILabel!
    @IBOutlet weak var emptyCount: UILabel!
    @IBOutlet weak var falseCount: UILabel!
    
    
    @IBOutlet weak var myAnswersButton: UIButton!
    @IBAction func myAnswer(_ sender: Any) {
        performSegue(withIdentifier:"myAnswers" , sender: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myAnswersButton.backgroundColor = UIColor.clear
        myAnswersButton.layer.cornerRadius = 18
        myAnswersButton.layer.borderWidth = 2
        myAnswersButton.layer.borderColor = #colorLiteral(red: 0.8304449556, green: 0.4671033306, blue: 0.00510714228, alpha: 1)
        myAnswersButton.layer.backgroundColor = #colorLiteral(red: 0.8304449556, green: 0.4671033306, blue: 0.00510714228, alpha: 1)
        
        
        var trueAnswer = 0
        var emptyAnswer = 0
        var falseAnswer = 0
        
        for answer in answerModels {
            if answer.myAnswer == answer.answer {
               trueAnswer = trueAnswer + 1
            }else if answer.myAnswer == "" {
                emptyAnswer = emptyAnswer + 1
            }else{
                falseAnswer = falseAnswer + 1
            }
            
        }
        emptyCount.text = String(emptyAnswer)
        trueCount.text = String(trueAnswer)
        falseCount.text = String(falseAnswer)
        questionCount.text = String(answerModels.count)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        		
        let resultCell = NSEntityDescription.insertNewObject(forEntityName: "Questions" , into: context)
        	
        resultCell.setValue(emptyAnswer, forKey: "emptyQuestion")
        resultCell.setValue(trueAnswer, forKey: "trueQuestion")
        resultCell.setValue(falseAnswer, forKey: "falseQuestion")
        resultCell.setValue(answerModels.count, forKey: "question")
        resultCell.setValue(currentQuestion?.id, forKey: "testId")
        resultCell.setValue(currentQuestion?.categoryName, forKey: "testName")
        resultCell.setValue(UUID(), forKey: "id")

        do{
            try context.save()
        }catch{
            print("error!")
         }
        
        
      
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                     if (segue.identifier == "myAnswers") {
                         let vc = segue.destination as! myAnsweredViewController
                         vc.answerModels = self.answerModels
                     }
                      
              }

        
}
    

  


