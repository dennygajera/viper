//
//  DashboardInteractor.swift
//  ViPER
//
//  Created by Darshan Gajera on 30/03/22.
//

import UIKit

class DashboardInteractor: PresenterToInteractor {
    var presenter: InteractorToPresenter?
    
    func fetchData() {
        
        WebServiceHandler.shared.getWebService(wsMethod: .all) { data in
            do {
                if let data = data {
                    let contests = try JSONDecoder().decode([ContestModel].self, from: ((data as NSDictionary).dataReturn()))
                    self.presenter?.successWithData(arrContest: contests)
               }
            } catch let err {
                print("Error while converting data into model", err.localizedDescription)
                self.presenter?.errorFromApi(objErr: err)
            }
        }
    }
}

