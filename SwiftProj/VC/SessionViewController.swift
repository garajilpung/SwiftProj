//
//  SessionViewController.swift
//  SwiftProj
//
//  Created by SMG on 9/9/24.
//  Copyright © 2024 garajilpung. All rights reserved.
//

import UIKit
import Combine

struct Post: Decodable {
//    let userId: Int
//    let id: Int
//    let title: String
//    let body: String
    
    let rrn1: String
    let rrn2: String
}

struct User2: Decodable, Encodable {
    let id: Int
    let name: String
    let email: String
}

@available(iOS 13.0, *)
class User2ViewModel {
    private var cancellables = Set<AnyCancellable>()
    
    @Published var textViewString : String = ""
    
    func userDataCall() {
        
        // 1. Create URL
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            fatalError("Invalid URL")
            
        }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [User2].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("User created successfully.")
                case .failure(let error):
                    print("Failed to create user: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] users in
                self?.textViewString = "name \(users[0].name)  email \(users[0].email)"
                
                for user in users {
                    print("name \(user.name)  email \(user.email)")
                }
            })
            .store(in: &cancellables)
    }
    
    func userDataCall2() {
        let newUser = User2(id: 111, name: "John Doe", email: "johndoe@example.com")
        
        callRequest.create(object: newUser, endpoint: "https://jsonplaceholder.typicode.com/users")
            .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        print("User created successfully.")
                    case .failure(let error):
                        print("Failed to create user: \(error.localizedDescription)")
                    }
                }, receiveValue: { (userResponse: User2) in  // Expecting UserResponse type
                    print("Created User Response: \(userResponse)")
                })
            .store(in: &cancellables)

    }
}

@available(iOS 13.0, *)
class callRequest {
    
    // Generic function to perform a POST request to create a new object of type T
    public static func create<RequestType: Codable, ResponseType: Codable> (
        object: RequestType,
        endpoint: String
    ) -> AnyPublisher<ResponseType, Error> {
        
        // 1. Create URL
        guard let url = URL(string: endpoint) else {
            fatalError("Invalid URL")
        }

        // 2. Create URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // 3. Encode the object data as JSON
        do {
            let jsonData = try JSONEncoder().encode(object)
            request.httpBody = jsonData
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }

        // 4. Make the network request with Combine
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: ResponseType.self.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main) // Ensure we receive results on the main thread
            .eraseToAnyPublisher()
    }
    
    
}

struct Post2: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

@available(iOS 13.0, *)
@objc(SessionViewController)
class SessionViewController: BasicViewController {

    @IBOutlet weak var textView: UITextView!
    
    private var users2: [User2] = []
    private var posts2: [Post2] = []
    
    
    private var cancellables = Set<AnyCancellable>()
    private var cancellable: AnyCancellable?
    
    // 실제 실행
    private var viewModel = User2ViewModel()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        viewModel.$textViewString
            .receive(on: DispatchQueue.main)
            .sink { [weak self] str in
                self?.textView.text = str
            }
            .store(in: &cancellables)
        
        viewModel.userDataCall()
        
//        let req = URLRequest(url: url)
//        URLSession.shared.dataTask(with: req) { data, response, error in
//            
//            
//            
//            if error == nil {
//                if let jsonString = String(data: data!, encoding: .utf8) {
//                    print("Received JSON: \(jsonString)")
//                }
//                let decoder = JSONDecoder()
//
//                do {
//                    // Decode JSON data into an array of Post
//                    let post = try decoder.decode(Post.self, from: data!)
//                    
//                    // Print each post
//                    print("Post ID: \(post.rrn1), Title: \(post.rrn2)")
//                } catch {
//                    print("Failed to decode JSON: \(error.localizedDescription)")
//                }
//            } else {
//                print("정상적인 입니다. \(error)")
//            }
//            
//           
////            
//        }.resume()
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onBtn(_ sender: Any) {
        
        fetchData()
    }

    private var posts: [Post] = [] {
        didSet {
            print("posts --> \(self.posts.count)")
        }
    }

    func cc() {
        // Step 1: Define the URL
        let url = URL(string: "https://garajilpung.synology.me/php/post11.json")!
        
        // Step 2: Create a URLSession data task publisher
        let publisher = URLSession.shared.dataTaskPublisher(for: url)
        
        // Step 3: Subscribe to the publisher
        let cancellable = publisher
            .map { $0.data }  // Extract only the data from the response
            .decode(type: [Post].self, decoder: JSONDecoder()) // Decode the JSON data into an array of Post structs
            .receive(on: DispatchQueue.main)  // Ensure we receive updates on the main thread
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        print("Request completed successfully.")
                    case .failure(let error):
                        print("Request failed with error: \(error)")
                    }
                },
                receiveValue: { posts in
                    
                    print("receive posts")
                    // Print the decoded struct array
                    for post in posts {
                        print("Post ID: \(post.rrn1), Title: \(post.rrn2)")
                    }
                }
            )
        
        self.cancellable = cancellable
    }
    
    func cd() {
        let url = URL(string: "https://garajilpung.synology.me/php/post11.json")!

        self.cancellable = URLSession.shared.dataTaskPublisher(for: url)
        .map { $0.data }
        .decode(type: [Post].self, decoder: JSONDecoder())
        .replaceError(with: [])
        .eraseToAnyPublisher()
        .assign(to: \.posts, on: self)
    }
    
    private func fetchData() {
        // Define the URLs
        let usersURL = URL(string: "https://jsonplaceholder.typicode.com/users")!
        let postsURL = URL(string: "https://jsonplaceholder.typicode.com/posts3")!
        
        // Create publishers for each request
        let usersPublisher = URLSession.shared.dataTaskPublisher(for: usersURL)
            .map { $0.data }
            .decode(type: [User2].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        
        let postsPublisher = URLSession.shared.dataTaskPublisher(for: postsURL)
            .map { $0.data }
            .decode(type: [Post2].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        
        // Combine the publishers
        Publishers.Zip(usersPublisher, postsPublisher)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    print("Data combined successfully.")
                case .failure(let error):
                    print("Error fetching data: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] users, posts in
                self?.users2 = users
                self?.posts2 = posts
//                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    
}
