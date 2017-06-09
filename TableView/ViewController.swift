import UIKit

class ViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate, UITableViewDelegate
    , SWApiResponseDelegate
{
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var people = [String]()
    
    var personName:String!
    
    var swapiPeople: SWApiPeople?
  
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        swapiPeople?.getList(searchText)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
       
        cell.textLabel?.text = people[indexPath.row];
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        personName = people[indexPath.row]
        
        performSegue(withIdentifier: "personSegue", sender: self)
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "personSegue") {
            // initialize new view controller and cast it as your view controller
            let viewController = segue.destination as! PersonViewController
            // your new view controller should have property that will store passed value
            viewController.personNameValue = personName
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        searchBar.delegate = self
        tableView.delegate = self
        
        swapiPeople = SWApiPeople()
        swapiPeople?.delegate = self
        swapiPeople?.getList()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dataDidLoad(people: [String]) {
        self.people = people
        DispatchQueue.main.async() { () -> Void in
            self.tableView.reloadData()
        }
    }
    
    collectionView
    
}

