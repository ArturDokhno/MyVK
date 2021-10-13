//
//  MyGroupSectionHeader.swift
//  6l_ArturDokhno
//
//  Created by Артур Дохно on 10.09.2021.
//

import UIKit

class MyGroupSectionHeader: UITableViewHeaderFooterView {

    override func prepareForReuse() {
        super.prepareForReuse()
        
        textLabel?.text = "detailTextLabel"
        detailTextLabel?.text = "detailTextLabel"
    }
    
}
