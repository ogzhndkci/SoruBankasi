//
//  CategoryListViewController.swift
//  questionBank
//
//  Created by oguz on 12.01.2020.
//  Copyright © 2020 oğuz hendekci. All rights reserved.
//

import UIKit

class CategoryListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var categoryTableView: UITableView!
    
    var categoryList = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        
        categoryList.append("KPSS")
        categoryList.append("DGS")
        categoryList.append("YKS TYT")
        categoryList.append("YDS")
        categoryList.append("LGS")
        categoryList.append("BANKA")
        categoryList.append("EHLİYET")
        categoryList.append("ADAY ÖĞRETMEN")
        
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.categoryTableView.dequeueReusableCell(withIdentifier: "categoryTableViewCell") as! UITableViewCell
        cell.detailTextLabel?.text = "10 deneme"

        cell.textLabel?.text = categoryList[indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toLessonsView", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if (segue.identifier == "toLessonsView") {
        let vc = segue.destination as! LessonsViewController
        vc.currentExam = self.categoryList[self.categoryTableView.indexPathForSelectedRow?.row ?? 0]
        }
    }
    
   
 
   
 

}
