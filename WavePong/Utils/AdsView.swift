import GoogleMobileAds
import UIKit
import SwiftUI

struct AdsView: View {
    
    var ads = RewardedAd()
    let stringsConstants = StringsConstantsModel()
    
    @State var buttonState = true
    
    var body: some View {
        Button(action: {
            buttonState = false
            ads.loadAndShow(rewardFunction: {
                // TODO: Get Reward
                buttonState = true
            })
        }) {
            
            if buttonState {
                Text(stringsConstants.ads)
                    .font(Font.wavePongPrimary(.body))
                    .foregroundColor(Color(ColorConstants.shared.WHITE_500))
                    .underline(color:Color(ColorConstants.shared.YELLOW_600))
            }
            else {
                Text(stringsConstants.carregando)
                    .font(Font.wavePongPrimary(.body))
                    .foregroundColor(Color(ColorConstants.shared.WHITE_500))
            }
        }
    }
}


class RewardedAd {
    private let rewardId = "ca-app-pub-4468906973477488/7219319001"
    // TODO: replace this with your own Ad ID
    // ID teste: ca-app-pub-3940256099942544/1712485313
    // Nosso ID: ca-app-pub-4468906973477488/7219319001
    
    var rewardedAd: GADRewardedAd?
    
    func load(){
        let request = GADRequest()
        // add extras here to the request, for example, for not presonalized Ads
        GADRewardedAd.load(withAdUnitID: rewardId, request: request, completionHandler: {rewardedAd, error in
            if error != nil {
                // loading the rewarded Ad failed :(
                return
            }
            self.rewardedAd = rewardedAd
        })
    }
    
    func showAd(rewardFunction: @escaping () -> Void) -> Bool {
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
    
    func loadAndShow(rewardFunction: @escaping () -> Void){
        let request = GADRequest()
        // add extras here to the request, for example, for not presonalized Ads
        GADRewardedAd.load(withAdUnitID: rewardId, request: request, completionHandler: {rewardedAd, error in
            if error != nil {
                // loading the rewarded Ad failed :(
                return
            }
            self.rewardedAd = rewardedAd
            self.showAd(rewardFunction: rewardFunction)
        })
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
