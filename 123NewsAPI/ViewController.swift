//
//  ViewController.swift
//  123NewsAPI
//
//  Created by Admin on 09.05.2021.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {

    var refreshControl: UIRefreshControl?
    var articles: [Article] = []
    var q = ""
    var selectedCountry = ""
    var selectedCategory = ""
    var selectedSources = ""
    var page = 1
    var pageSize = 20
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addRefreshControl()
        
        loadNews(refresh: true)
        
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        self.q = self.searchText.text ?? ""
        print(q)
        loadNews(refresh: true)
    }
    
    
    
    func addRefreshControl() {
        refreshControl = UIRefreshControl()
//        refreshControl?.tintColor = UIColor.red
        refreshControl?.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        tableView.addSubview(refreshControl!)
    }
    
    @objc func refreshList() {
        refreshControl?.endRefreshing()

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func loadNews(refresh: Bool) {
        if refresh {
            articles = []
        }
        
        // add page and pagesize
        NetworkManager.shared.loadNews(q: q,
                                       selectedCountry: selectedCountry,
                                       selectedCategory: selectedCategory,
                                       selectedSources: selectedSources,
                                       page:page,
                                       pageSize:pageSize,
                                       completion: { [weak self] (articles) in
                                        self?.articles.append(contentsOf: articles)
                                        DispatchQueue.main.async {
                                            self?.tableView.reloadData()
                                        }
                                       })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? SettingsOfFilterViewController else { return }
        
        vc.didSelectCountry = { [weak self] (country) in
            self?.selectedCountry = country
            self?.loadNews(refresh: true)
            self?.navigationController?.popViewController(animated: true)
        }
        
        vc.didSelectCategory = { [weak self] (category) in
            self?.selectedCategory = category
            self?.loadNews(refresh: true)
            self?.navigationController?.popViewController(animated: true)
        }
        
        vc.didSelectSources = { [weak self] (sources) in
            self?.selectedSources = sources
            self?.loadNews(refresh: true)
            self?.navigationController?.popViewController(animated: true)
        }
    }
}

    

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 202
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell {
            let art = self.articles[indexPath.row]
            cell.titleLable.text = art.title
            cell.descriptionLable.text = art.content
            cell.sourseLable.text = art.sourseName
            cell.authorLable.text = art.author
            cell.dateOfPublish.text = art.publishedAt
            cell.imgView.sd_setImage(with: URL (string: art.urlToImage), completed: nil)
            return cell
        }
        return UITableViewCell( )
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = self.articles[indexPath.row]
        guard let url = URL(string: article.url) else { return }
        let vc = WebViewViewController(url: url, title: "News")
        let navVc = UINavigationController(rootViewController: vc)
        present(navVc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == articles.count - 2 {
            page += 1
            loadNews(refresh: false)
        }
    }
}


