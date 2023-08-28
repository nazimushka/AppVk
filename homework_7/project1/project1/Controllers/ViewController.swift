import WebKit
import UIKit



final class ViewController: UIViewController {
    private lazy var webView: WKWebView = {
        let webView = WKWebView(frame: view.bounds)
        webView.navigationDelegate = self
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        
        let url = URL(string: "https://oauth.vk.com/authorize?client_id=51728151&redirect_uri=https://oauth.vk.com/blank.html&scope=262150&display=mobile&response_type=token")
        
        guard let url else{
            return
        }
        webView.load(URLRequest(url: url))
        
    }
    
    private func setupViews(){
        view.addSubview(webView)
    }
    
    
    private func tap() {
        
        let tab1 = UINavigationController(rootViewController: FriendsController(networkService: NetworkService(), models: [], fileCache: FileCache()))
        let tab2 = UINavigationController(rootViewController: GroupsController())
        let tab3 = UINavigationController(rootViewController: PhotoController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        
        
        tab1.tabBarItem.title = "Friends"
        tab2.tabBarItem.title = "Groups"
        tab3.tabBarItem.title = "Photos"
        
        
        let controllers = [tab1, tab2, tab3]
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = controllers
        
        guard let firstScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let firstWindow = firstScene.windows.first else {
            return
        }
        
        
        firstWindow.rootViewController =  tabBarController
        
    }
    
    
}


extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponce:
                 WKNavigationResponse, decisionHandler: @escaping
                 (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponce.response.url, url.path == "/blank.html", let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        let param = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=")}
            .reduce([String: String]()){ result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        NetworkService.token = param["access_token"]
        NetworkService.userId = param["user_id"]
        decisionHandler(.cancel)
        webView.removeFromSuperview()
        tap()
    }
}

