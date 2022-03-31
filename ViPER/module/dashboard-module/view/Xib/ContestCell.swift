//
//  ContestCell.swift
//  ViPER
//
//  Created by Darshan Gajera on 30/03/22.
//

import Foundation
import UIKit

class ContestCell: UITableViewCell {
    // MARK: Outlets
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var lblSite: UILabel!
    static let reuseidentifier = "ContestCell"
    
    /// set contest data
    func setData(contestData: ContestModel) {
        lblName.text = contestData.name
        lblSite.text = contestData.site
        if let startTime = contestData.start_time {
            lblStartDate.text = startTime.convertToDateFormat()
        }
        selectionStyle = .none
    }
}
