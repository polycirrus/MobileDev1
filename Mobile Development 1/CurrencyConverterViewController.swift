import UIKit

class CurrencyConverterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    let converter = CurrencyConverter()
    var value: Double?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func onTextBoxEditingChanged(sender: UITextField) {
        if let text = sender.text {
            value = Double(text)
        }
        else {
            value = nil
        }
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        return
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return converter.currencies.count
        }
        return 0;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Value2, reuseIdentifier: nil)
        cell.textLabel?.textAlignment = NSTextAlignment.Left
        
        if let unwrappedValue = value {
            let convertedValue = converter.ConvertTo(unwrappedValue, currency: converter.currencies[indexPath.row])
            cell.textLabel?.text = String(convertedValue)
        }
        else {
            cell.textLabel?.text = ""
        }
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        cell.detailTextLabel?.text = converter.currencies[indexPath.row].name
        
        return cell
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
