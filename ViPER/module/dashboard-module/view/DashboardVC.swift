//
//  DashboardVC.swift
//  ViPER
//
//  Created by Darshan Gajera on 30/03/22.
//

import UIKit

class DashboardVC: UIViewController {
    var presenter: ViewToPresenter?
    var arrContest = [ContestModel]()
    
    //MARK: Outlet and Variable
    @IBOutlet weak var tblView: UITableView! {
        didSet {
            tblView.register(UINib(nibName: "ContestCell", bundle: nil), forCellReuseIdentifier: ContestCell.reuseidentifier)
            tblView.addSubview(refreshControl)
        }
    }
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
                                    #selector(refresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.gray
        refreshControl.attributedTitle = NSAttributedString(string: "Loading.....")
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DashboardRouter.createModule(view: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchDashboardData()
    }
    
    func fetchDashboardData() {
        presenter?.fetchdata()
        refreshControl.endRefreshing()
    }
    
    //MARK: refresh- To Refreh tableview
    @objc func refresh(_ sender: AnyObject) {
        fetchDashboardData()
    }
}

extension DashboardVC: PresenterToView {
    func successWithData(arrContest: [ContestModel]) {
        self.arrContest = arrContest
        DispatchQueue.main.async {
            self.tblView.reloadData {
                self.tblView.layoutIfNeeded()
                self.view.layoutIfNeeded()
            }

        }
    }
    
    func errorFromApi(objErr: Error) {
        print(objErr.localizedDescription)
    }
}

//MARK: Tablview Delegate
extension DashboardVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.arrContest.count)
        return self.arrContest.count
    }
    
    /// Fetch all data from the server and set into tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ContestCell = tableView.dequeueReusableCell(for: indexPath)
        let singleContest = self.arrContest[indexPath.row]
        /// pass contest data to the tableviewcell's method\
        cell.setData(contestData: singleContest)
        return cell
    }
    
    /// open ios default browser to load contest link
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let singleContest = self.arrContest[indexPath.row]
        if let url = singleContest.url {
            self.openURL(strUrl: url)
        }
    }
}

extension UITableView {
    func reloadData(completion:@escaping ()->()) {
        UIView.animate(withDuration: 0, animations: reloadData)
            { _ in completion() }
    }
}
