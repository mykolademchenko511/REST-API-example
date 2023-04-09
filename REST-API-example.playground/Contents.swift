import UIKit
// GET, POST, PUT, DELETE
func makePOSTRequest() {
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
        return
    }
    let startTime = DispatchTime.now()
    
    let endTime = DispatchTime.now()
   
    
    var request = URLRequest(url: url)
    //method, body, headers
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    let body: [String: AnyHashable] = [
        "userId": 1,
        "title": "Hello everyone !",
        "body": "Hello everyone !Hello everyone !Hello everyone !Hello everyone !Hello everyone !Hello everyone !Hello everyone !"
    ]
    request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
    //Make the request
    let task  = URLSession.shared.dataTask(with: request) { data, _, error in
        guard let data = data, error == nil else {
            return
        }
        
        do  {
            let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            print("Success:", response)
            //Measure time API call took.
            let timeElapsed = Double(endTime.uptimeNanoseconds - startTime.uptimeNanoseconds) / 1_000_000_000
            print("API call took \(timeElapsed) seconds to complete.")
        }
        catch {
            print(error)
        }
    }.resume()
}

makePOSTRequest()
