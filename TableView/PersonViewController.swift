
import UIKit

class PersonViewController: UIViewController {

    @IBOutlet weak var personNameLabel: UILabel!
    
    var personNameValue:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        personNameLabel.text = personNameValue
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
