//
//  QuestionViewController.swift
//  questionBank
//
//  Created by oguz on 14.03.2020.
//  Copyright © 2020 oğuz hendekci. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import WebKit



class QuestionViewController: UIViewController {
    
    var questionModels = [questionModel]()
    var answerModels = [answerModel]()
    var currentQuestion : categoryModel?
    var currentIndex = 0
    var firstQuestion = questionModel()
    var myAnswer = ""

    @IBOutlet weak var questionWebView: WKWebView!
    @IBOutlet weak var aButton: UIButton!
    @IBOutlet weak var bButton: UIButton!
    @IBOutlet weak var cButton: UIButton!
    @IBOutlet weak var dButton: UIButton!
    @IBOutlet weak var eButton: UIButton!
    @IBOutlet weak var nextQuestion: UIButton!
    @IBAction func aButton(_ sender: Any) {
        colorDetected(char:"A",button: aButton)

    }
    @IBAction func bButton(_ sender: Any) {
         colorDetected(char:"B",button: bButton)

    }
    @IBAction func cButton(_ sender: Any) {
         colorDetected(char:"C",button: cButton)
    }
    @IBAction func dButton(_ sender: Any) {
         colorDetected(char:"D",button: dButton)
    }
    @IBAction func eButton(_ sender: Any) {
        colorDetected(char:"E",button: eButton)
    }
    
    @IBAction func nextQuestion(_ sender: Any) {
        let idCount = answerModels.filter { (answer : answerModel) -> Bool in
                  return firstQuestion.id == answer.id
              }.count
              if idCount == 0 {
                  self.answerModels.append(answerModel(id: firstQuestion.id, myAnswer: myAnswer , answer: firstQuestion.answer))
              }else{
                  let firstAnswer = answerModels.filter { (answer : answerModel) -> Bool in
                           return firstQuestion.id == answer.id
                       }.first
                  firstAnswer?.myAnswer = myAnswer
              }
        myAnswer = ""
              
        
        
        let result = questionModels.count
        if result > currentIndex + 1 {
        currentIndex = currentIndex + 1
         self.getQuestion()
            self.fillQuestionAnswer()
            
    
        
        }else{
            performSegue(withIdentifier: "toResultView", sender: nil)
        }
       
    }
    @IBAction func previousQuestion(_ sender: Any) {
        if currentIndex > 0   {
        currentIndex = currentIndex - 1
        self.getQuestion()
            self.fillQuestionAnswer()
      
            
        }
        
    }
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.borderButton()
        
       
        
        let parameters: [String: Any] = [
                              
                              "access_key" : "6808",
                              "get_questions_by_subcategory" : "1",
                              "subcategory" : currentQuestion?.id    ]
        
               AF.request("https://cagrican.com/kpss/api-v2.php", method: .post, parameters: parameters).response {
                         
                         response in
                         switch response.result {

                         case .success(let responseData):
                             do{
                                 let responseJson = try JSON(data: responseData!)
                               for item in responseJson["data"].arrayValue {
                                   print(item["id"].stringValue)
                                  var questions  = questionModel()
                                   questions.question = item["question"].stringValue
                                   questions.optiona = item["optiona"].stringValue
                                   questions.optionb = item["optionb"].stringValue
                                   questions.optionc = item["optionc"].stringValue
                                   questions.optiond = item["optiond"].stringValue
                                   questions.optione = item["optione"].stringValue
                                   questions.answer = item["answer"].stringValue
                                   questions.id = item["id"].intValue
                                   self.questionModels.append(questions)
                               }
                                                                
                                if self.questionModels.count == 0 {
                                   makeAlert(titleInput: "Soru Bulunamadı!", messageInput: "En kısa zamanda ekleyeceğiz")
                                    
                                }else{
                                    
                                    self.getQuestion()
                                
                                
                             }
                             }
                             catch {
                             }
                            
                         case .failure(let error): break
                    }
    
                }
        func makeAlert(titleInput:String, messageInput:String) {
               let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                self.navigationController?.popViewController(animated: true)
            }))
                
            
            
            
               self.present(alert, animated: true, completion: nil)
           }
        
        
        }
    func getQuestion() {
        self.firstQuestion = self.questionModels[self.currentIndex]

            
            
            self.questionWebView.loadHTMLString(firstQuestion.question ?? "" , baseURL: nil)
        self.aButton.setTitle(firstQuestion.optiona ,for: .normal)
        self.bButton.setTitle(firstQuestion.optionb ,for: .normal)
        self.cButton.setTitle(firstQuestion.optionc ,for: .normal)
        self.dButton.setTitle(firstQuestion.optiond ,for: .normal)
        self.eButton.setTitle(firstQuestion.optione ,for: .normal)
       
    }

    func borderButton() {
        aButton.backgroundColor = UIColor.clear
        aButton.layer.cornerRadius = 18
        aButton.layer.borderWidth = 1
        aButton.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        aButton.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        bButton.backgroundColor = UIColor.clear
        bButton.layer.cornerRadius = 18
        bButton.layer.borderWidth = 1
        bButton.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        bButton.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        cButton.backgroundColor = UIColor.clear
        cButton.layer.cornerRadius = 18
        cButton.layer.borderWidth = 1
        cButton.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cButton.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        dButton.backgroundColor = UIColor.clear
        dButton.layer.cornerRadius = 18
        dButton.layer.borderWidth = 1
        dButton.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        dButton.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        eButton.backgroundColor = UIColor.clear
        eButton.layer.cornerRadius = 18
        eButton.layer.borderWidth = 1
        eButton.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        eButton.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
    }
    
    func colorDetected(char:String,button:UIButton){
         if self.myAnswer != "" {
                 return
             }
        self.myAnswer = char
      
       if self.firstQuestion.answer == char  {
           button.backgroundColor = UIColor.green
         
       
       }else{
           button.backgroundColor = UIColor.red
            
           }
        switch  self.firstQuestion.answer {
            case "A":
            aButton.backgroundColor = UIColor.green
            case "B":
            bButton.backgroundColor = UIColor.green
            case "C":
            cButton.backgroundColor = UIColor.green
            case "D":
            dButton.backgroundColor = UIColor.green
            case "E":
            eButton.backgroundColor = UIColor.green
        default:
            aButton.backgroundColor = UIColor.green
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if (segue.identifier == "toResultView") {
          let vc = segue.destination as! ResultViewController
            vc.answerModels = self.answerModels
        vc.currentQuestion = self.currentQuestion
      }
        
    }
    func fillQuestionAnswer() {
    aButton.backgroundColor = UIColor.white
          bButton.backgroundColor = UIColor.white
          cButton.backgroundColor = UIColor.white
          dButton.backgroundColor = UIColor.white
          eButton.backgroundColor = UIColor.white
          
          let firstAnswer = self.answerModels.first{$0.id == firstQuestion.id}
          
          
          if firstAnswer?.answer == "A"{
               aButton.backgroundColor = UIColor.green
          }else if firstAnswer?.answer == "B"{
              bButton.backgroundColor = UIColor.green
          }else if firstAnswer?.answer == "C"{
              cButton.backgroundColor = UIColor.green
          }else if firstAnswer?.answer == "D"{
              dButton.backgroundColor = UIColor.green
          }else if firstAnswer?.answer == "E"{
              eButton.backgroundColor = UIColor.green
          }
          
          if firstAnswer?.myAnswer != firstAnswer?.answer{
          
              if firstAnswer?.myAnswer == "A"{
                          aButton.backgroundColor = UIColor.red
              }else if firstAnswer?.myAnswer == "B"{
                         bButton.backgroundColor = UIColor.red
              }else if firstAnswer?.myAnswer == "C"{
                         cButton.backgroundColor = UIColor.red
              }else if firstAnswer?.myAnswer == "D"{
                         dButton.backgroundColor = UIColor.red
              }else if firstAnswer?.myAnswer == "E"{
                         eButton.backgroundColor = UIColor.red
              }
          }
  
}
}
