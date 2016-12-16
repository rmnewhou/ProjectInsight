//
//

import UIKit

class PageViewController: UIPageViewController
{
    // Walkthrough screen text
    var pageHeaders = ["Welcome to Insight Study Buider", "View Studies", "Create Studies", "Coming Soon!", "Researching made easy!"]
    var pageImages = ["questionMarkIcon", "questionMarkIcon", "questionMarkIcon", "questionMarkIcon", "questionMarkIcon"]
    var pageDescriptions = ["Answer studies created by others or create your own by customizing questions and tasks.", "Check out the latest studies created by other users. ", "Use our unique task builder to join questions in tasks together for a study specific to your needs.", "Multiple features on the way!", ""]
   
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        
        //create first walkthrough screen
        if let startWalkthroughVC = self.viewControllerAtIndex(0) {
            setViewControllers([startWalkthroughVC], direction: .forward, animated: true, completion: nil)
        }
        
    }
    
    // MARK: - Navigate
    
    func nextPageWithIndex(_ index: Int)
    {
        if let nextWalkthroughVC = self.viewControllerAtIndex(index+1) {
            setViewControllers([nextWalkthroughVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func viewControllerAtIndex(_ index: Int) -> WalkthroughViewController?
    {
        if index == NSNotFound || index < 0 || index >= self.pageDescriptions.count {
            return nil
        }
        
        // create a new walkthrough view controller
        if let walkthroughViewController = storyboard?.instantiateViewController(withIdentifier: "WalkthroughViewController") as? WalkthroughViewController {
            walkthroughViewController.imageName = pageImages[index]
            walkthroughViewController.headerText = pageHeaders[index]
            walkthroughViewController.descriptionText = pageDescriptions[index]
            walkthroughViewController.index = index
            
            return walkthroughViewController
        }
        
        return nil
    }
}

extension PageViewController : UIPageViewControllerDataSource
{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        var index = (viewController as! WalkthroughViewController).index
        index += 1
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughViewController).index
        index -= 1
        return self.viewControllerAtIndex(index)
    }
}






















