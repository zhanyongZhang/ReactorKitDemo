//
//  ViewController.swift
//  ReactorKitDemo
//
//  Created by allen_zhang on 2019/4/1.
//  Copyright © 2019 com.mljr. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import MBProgressHUD

class ViewController: UIViewController, View {
    
    var disposeBag: DisposeBag = DisposeBag()
    typealias Reactor = ViewReactor
    
    var tableView: UITableView!
    var searchBar: UISearchBar!
    var loadingHUD: MBProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView = UITableView(frame:self.view.frame, style:.plain)
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView!)
        
        self.searchBar = UISearchBar(frame: CGRect(x: 0, y: 0,
                                                   width: self.view.bounds.size.width, height: 56))
        self.tableView.tableHeaderView =  self.searchBar
        self.loadingHUD = MBProgressHUD.showAdded(to: self.view, animated: false)
        self.reactor = ViewReactor()
        
    }
    
    func bind(reactor: Reactor) {
        
        searchBar.rx.text.orEmpty.changed
            .throttle(0.3, scheduler: MainScheduler.instance).distinctUntilChanged().map(Reactor.Action.updateQuery).bind(to: reactor.action).disposed(by: disposeBag)
        reactor.state.map { $0.results }.bind(to: self.tableView.rx.items){ (tableView, row, element) in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = element.name
            cell.detailTextLabel?.text = element.htmlUrl
            return cell
            
            }.disposed(by: disposeBag)
        
        reactor.state.map { $0.title }.bind(to: navigationItem.rx.title).disposed(by: disposeBag)
        
        reactor.state.map { !$0.loading }.bind(to: loadingHUD.rx.isHidden).disposed(by: disposeBag)
    }
}

