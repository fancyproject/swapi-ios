import Foundation

protocol SWApiResponseDelegate {
    func dataDidLoad(people: [String])
    //    func dataDidLoad(plants: [String])
    //    func responseError(_ error: String)
}

class SWApiPeople : SWApi {
    
    private func parseList(jsonData: Data){
        
        do {
            
            let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String:Any]
            
            let results = json?["results"] as! NSArray
            
            var people = [String]()
            for i in 0 ..< results.count {
                
                let person = results[i] as? [String:Any]
                let name = person?["name"] as? String
                people.append(name ?? "")
            }
            self.delegate?.dataDidLoad(people: people)
            
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    func getList(_ search: String = "", _ page: Int = 1){
        
        let url = URL.init(string: baseUrl + "people?search=\(search)&page=\(page)")
        
        sendRequest(
            url: url!,
            successCallback: { (json) in
                self.parseList(jsonData: json)
        })
    }
}

class SWApi{
    
    let baseUrl = "https://swapi.co/api/"
    
    var delegate:SWApiResponseDelegate?
    
    internal func sendRequest(url: URL, successCallback: (@escaping (_ json: Data) -> Void)){
        
        let session = URLSession.shared;
        
        // cancel previous requests
        session.getTasksWithCompletionHandler { (dataTasks, uploadTasks, downloadTasks) in
            for task in dataTasks {
                task.cancel()
            }
        }
        
        // get data from api
        session.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
                //print(error)
            } else {
                successCallback(data!);
            }
        }).resume();
    }
}
