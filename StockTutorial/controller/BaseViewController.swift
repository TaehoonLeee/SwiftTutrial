import UIKit
import RxSwift
import Combine

class BaseViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    var subscriber: Set<AnyCancellable> = .init()
    private var scrollView: UIScrollView?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    override func viewDidLoad() {
        configureUI()
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground
    }
    
    func enableScrollWhenKeyboardAppeared(scrollView: UIScrollView) {
        self.scrollView = scrollView
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeListener() {
        NotificationCenter.default.removeObserver(self)
    }
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let scrollView = scrollView else { return }
        guard let userInfo = notification.userInfo else { return }
        
        let keyboardFrame: CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        var contentInset: UIEdgeInsets = scrollView.contentInset
        
        contentInset.bottom = keyboardFrame.size.height + 20
        scrollView.contentInset = contentInset
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        guard let scrollView = scrollView else { return }
        let contentInset: UIEdgeInsets = .zero
        
        scrollView.contentInset = contentInset
    }
}
