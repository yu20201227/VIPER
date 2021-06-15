//
//  Interactor.swift
//  VIPER(シャキョウ）
//
//  Created by Owner on 2021/06/13.
//

import Foundation

protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
    
    //presenterに取得完了を知らせる
    func letPresenterKnowFetchingHasDone()
}

class UserInteractor: AnyInteractor {
    
    var presenter: AnyPresenter?

    func letPresenterKnowFetchingHasDone() {
        print("start Fetching")
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        let task = URLSession.shared.dataTask(with: url) { [unowned self] data, _, error in
            guard let data = data, error == nil else {
                self.presenter?.receiveDataFromInteractor(with: .failure(FetchError.failed))
                return
            }
            do {
                let entities = try JSONDecoder().decode([User].self, from: data)
                self.presenter?.receiveDataFromInteractor(with: .success(entities))
            }
            catch {
                self.presenter?.receiveDataFromInteractor(with: .failure(error))
            }
        }
        task.resume()
    }
    
    
    
}
