import UIKit

struct UserData {
    let userID: String
    let userName: String
    let subject: String
    let message: String
}


class TestSwiftTableView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var userDataList: [UserData] = []  // 外部から渡される動的データ
    
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // テーブルビューの設定
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UserCell")
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        // テーブルビューの制約
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        let userData = userDataList[indexPath.row]
        
        cell.textLabel?.text = "UserID: \(userData.userID)\nUserName: \(userData.userName)\nSubject: \(userData.subject)\nMessage: \(userData.message)"
        cell.textLabel?.numberOfLines = 0
        
        return cell
    }
}
