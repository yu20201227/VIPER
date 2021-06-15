//
//  View.swift
//  VIPER(シャキョウ）
//
//  Created by Owner on 2021/06/13.
//

import UIKit

protocol AnyView {
    var presenter: AnyPresenter? { get set }
    
    func update(with users: [User])
    func update(with error: String)
}

class UserViewController: UIViewController, AnyView, UITableViewDelegate, UITableViewDataSource {
    
    var presenter: AnyPresenter?
    
    var users: [User] = []
    
    private var tableView: UITableView {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = false
        return table
    }
    
    private var label: UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.isHidden = true
        return label
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        view.backgroundColor = .systemRed
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
        
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        label.center = view.center
    }

    
    func update(with users: [User]) {
        print("got Users Data")
        DispatchQueue.main.async {
            self.users = users
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    func update(with error: String) {
        print("failed to update")
        DispatchQueue.main.async {
            self.users = []
            self.tableView.isHidden = true
            self.label.isHidden = false
            self.label.text = error
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }

    
    
    
}
