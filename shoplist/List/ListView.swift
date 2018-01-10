//
//  ListView.swift
//  shoplist
//
//  Created by Krzysztof Piatkowski on 01/01/2018.
//  Copyright © 2018 Krzysztof Piatkowski. All rights reserved.
//

import UIKit

class ListView : BaseView {
    fileprivate var contentView = UIView()
    var autoCompleterTextField = UITextField()
    var tableView = UITableView()
    
    override init() {
        super.init()

        addSubview(contentView)
        
        autoCompleterTextField = UITextField(frame: CGRect.zero)
        autoCompleterTextField.borderStyle = .roundedRect
        contentView.addSubview(self.autoCompleterTextField)
    
        tableView = UITableView(frame: CGRect.zero)
        tableView.tableFooterView = UIView()
        contentView.addSubview(self.tableView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.pin.all().margin(safeArea)

        self.autoCompleterTextField.pin.top(10).left(10).right(10).height(31)
        self.tableView.pin.below(of: self.autoCompleterTextField).marginTop(10).horizontally().bottom()
    }
}


