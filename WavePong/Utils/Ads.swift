import GoogleMobileAds
import UIKit
import SwiftUI

struct AdsView: View {
    
    @State var collectedDiamonds: Int = 0
    
    @StateObject var ads: RewardedAd = RewardedAd.shared
    
    var canShow: Bool {
        ads.addIsLoaded
    }
    
    var body: some View {
        if canShow {
            Button(action: {
                self.ads.showAd(rewardFunction: {
                    // TODO: give the user a reward for watching
                    self.collectedDiamonds += 1
                })
            }) {
                Text("Watch Ad - Earn 💎")
                    .foregroundColor(.white)
                    .padding()
            }
            .background(Capsule().fill(Color.blue))
        }
        else {
            Button(action: {
                ads.load()
            }) {
                Text("Reload add - 🔁")
                    .foregroundColor(.white)
                    .padding()
            }
            .background(Capsule().fill(Color.cyan))
        }
    }
}


class RewardedAd: ObservableObject {
    private let rewardId = "ca-app-pub-3940256099942544/1712485313" // TODO: replace this with your own Ad ID
    // Nosso: ca-app-pub-4468906973477488/7219319001
    
    @Published var rewardedAd: GADRewardedAd?
    
    static var shared = RewardedAd()
    
    @Published var addIsLoaded = false
    
    func load(){
        let request = GADRequest()
        // add extras here to the request, for example, for not presonalized Ads
        GADRewardedAd.load(withAdUnitID: rewardId, request: request, completionHandler: {rewardedAd, error in
            if error != nil {
                // loading the rewarded Ad failed :(
                return
            }
            self.rewardedAd = rewardedAd
            self.addIsLoaded = true
            print(self.addIsLoaded)
        })
    }
    
    func showAd(rewardFunction: @escaping () -> Void) -> Bool {
        self.addIsLoaded = false
        guard let rewardedAd = rewardedAd
        else {
            return false
        }
        
        guard let root = UIApplication.shared.keyWindowPresentedController else {
            return false
        }
        rewardedAd.present(fromRootViewController: root, userDidEarnRewardHandler: rewardFunction)
        return true
    }
}

// just an extension to make our life easier to receive the root view controller
extension UIApplication {
    
    var keyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first(where: { $0 is UIWindowScene })
            .flatMap({ $0 as? UIWindowScene })?.windows
            .first(where: \.isKeyWindow)
    }
    
    var keyWindowPresentedController: UIViewController? {
        var viewController = self.keyWindow?.rootViewController
        
        if let presentedController = viewController as? UITabBarController {
            viewController = presentedController.selectedViewController
        }
        
        while let presentedController = viewController?.presentedViewController {
            if let presentedController = presentedController as? UITabBarController {
                viewController = presentedController.selectedViewController
            } else {
                viewController = presentedController
            }
        }
        return viewController
    }
}
