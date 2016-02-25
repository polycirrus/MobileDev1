//
//  StudentsViewController.swift
//  Mobile Development 1
//
//  Created by Александр on 2/15/16.
//
//

import UIKit

class StudentsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private let students = StudentsList.students
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Value2, reuseIdentifier: nil)
        cell.textLabel?.textAlignment = NSTextAlignment.Left
        
        //cell.detailTextLabel?.text = String(indexPath.row)
        //cell.textLabel?.numberOfLines = 0
        //cell.textLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        //cell.textLabel?.text = students[indexPath.row]
        
        cell.textLabel?.text = String(indexPath.row + 1)
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        cell.detailTextLabel?.text = students[indexPath.row]
        
        return cell
    }

}
