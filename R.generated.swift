//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import RswiftResources
import UIKit

private class BundleFinder {}
let R = _R(bundle: Bundle(for: BundleFinder.self))

struct _R {
  let bundle: Foundation.Bundle

  let segue = segue()
  let reuseIdentifier = reuseIdentifier()

  var color: color { .init(bundle: bundle) }
  var info: info { .init(bundle: bundle) }
  var nib: nib { .init(bundle: bundle) }
  var storyboard: storyboard { .init(bundle: bundle) }

  func color(bundle: Foundation.Bundle) -> color {
    .init(bundle: bundle)
  }
  func info(bundle: Foundation.Bundle) -> info {
    .init(bundle: bundle)
  }
  func nib(bundle: Foundation.Bundle) -> nib {
    .init(bundle: bundle)
  }
  func storyboard(bundle: Foundation.Bundle) -> storyboard {
    .init(bundle: bundle)
  }
  func validate() throws {
    try self.nib.validate()
    try self.storyboard.validate()
  }

  struct project {
    let developmentRegion = "en"
  }

  /// This `_R.color` struct is generated, and contains static references to 1 colors.
  struct color {
    let bundle: Foundation.Bundle

    /// Color `AccentColor`.
    var accentColor: RswiftResources.ColorResource { .init(name: "AccentColor", path: [], bundle: bundle) }
  }

  /// This `_R.info` struct is generated, and contains static references to 1 properties.
  struct info {
    let bundle: Foundation.Bundle
    var uiApplicationSceneManifest: uiApplicationSceneManifest { .init(bundle: bundle) }

    func uiApplicationSceneManifest(bundle: Foundation.Bundle) -> uiApplicationSceneManifest {
      .init(bundle: bundle)
    }

    struct uiApplicationSceneManifest {
      let bundle: Foundation.Bundle

      let uiApplicationSupportsMultipleScenes: Bool = false

      var _key: String { bundle.infoDictionaryString(path: ["UIApplicationSceneManifest"], key: "_key") ?? "UIApplicationSceneManifest" }
      var uiSceneConfigurations: uiSceneConfigurations { .init(bundle: bundle) }

      func uiSceneConfigurations(bundle: Foundation.Bundle) -> uiSceneConfigurations {
        .init(bundle: bundle)
      }

      struct uiSceneConfigurations {
        let bundle: Foundation.Bundle
        var _key: String { bundle.infoDictionaryString(path: ["UIApplicationSceneManifest", "UISceneConfigurations"], key: "_key") ?? "UISceneConfigurations" }
        var uiWindowSceneSessionRoleApplication: uiWindowSceneSessionRoleApplication { .init(bundle: bundle) }

        func uiWindowSceneSessionRoleApplication(bundle: Foundation.Bundle) -> uiWindowSceneSessionRoleApplication {
          .init(bundle: bundle)
        }

        struct uiWindowSceneSessionRoleApplication {
          let bundle: Foundation.Bundle
          var defaultConfiguration: defaultConfiguration { .init(bundle: bundle) }

          func defaultConfiguration(bundle: Foundation.Bundle) -> defaultConfiguration {
            .init(bundle: bundle)
          }

          struct defaultConfiguration {
            let bundle: Foundation.Bundle
            var uiSceneConfigurationName: String { bundle.infoDictionaryString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication"], key: "UISceneConfigurationName") ?? "Default Configuration" }
            var uiSceneDelegateClassName: String { bundle.infoDictionaryString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication"], key: "UISceneDelegateClassName") ?? "$(PRODUCT_MODULE_NAME).SceneDelegate" }
            var uiSceneStoryboardFile: String { bundle.infoDictionaryString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication"], key: "UISceneStoryboardFile") ?? "Main" }
          }
        }
      }
    }
  }

  /// This `_R.segue` struct is generated, and contains static references to 1 view controllers.
  struct segue {
    let dailyNewsController = dailyNewsController()

    /// This struct is generated for `DailyNewsController`, and contains static references to 1 segues.
    struct dailyNewsController {

      /// Segue identifier `newsDetailSegue`.
      var newsDetailSegue: RswiftResources.SegueIdentifier<UIKit.UIStoryboardSegue, DailyNewsController, NewsDetailViewController> { .init(identifier: "newsDetailSegue") }
    }
  }

  /// This `_R.nib` struct is generated, and contains static references to 1 nibs.
  struct nib {
    let bundle: Foundation.Bundle

    /// Nib `DailyNewsItemCell`.
    var dailyNewsItemCell: RswiftResources.NibReferenceReuseIdentifier<DailyNewsItemCell, DailyNewsItemCell> { .init(name: "DailyNewsItemCell", bundle: bundle, identifier: "DailyNewsItemCell") }

    func validate() throws {

    }
  }

  /// This `_R.reuseIdentifier` struct is generated, and contains static references to 2 reuse identifiers.
  struct reuseIdentifier {

    /// Reuse identifier `DailyNewsItemCell`.
    let dailyNewsItemCell: RswiftResources.ReuseIdentifier<DailyNewsItemCell> = .init(identifier: "DailyNewsItemCell")

    /// Reuse identifier `newsFooterView`.
    let newsFooterView: RswiftResources.ReuseIdentifier<UIKit.UICollectionReusableView> = .init(identifier: "newsFooterView")
  }

  /// This `_R.storyboard` struct is generated, and contains static references to 2 storyboards.
  struct storyboard {
    let bundle: Foundation.Bundle
    var launchScreen: launchScreen { .init(bundle: bundle) }
    var main: main { .init(bundle: bundle) }

    func launchScreen(bundle: Foundation.Bundle) -> launchScreen {
      .init(bundle: bundle)
    }
    func main(bundle: Foundation.Bundle) -> main {
      .init(bundle: bundle)
    }
    func validate() throws {
      try self.launchScreen.validate()
      try self.main.validate()
    }


    /// Storyboard `LaunchScreen`.
    struct launchScreen: RswiftResources.StoryboardReference, RswiftResources.InitialControllerContainer {
      typealias InitialController = UIKit.UIViewController

      let bundle: Foundation.Bundle

      let name = "LaunchScreen"
      func validate() throws {

      }
    }

    /// Storyboard `Main`.
    struct main: RswiftResources.StoryboardReference, RswiftResources.InitialControllerContainer {
      typealias InitialController = UIKit.UITabBarController

      let bundle: Foundation.Bundle

      let name = "Main"

      var initialNavigationController: RswiftResources.StoryboardViewControllerIdentifier<UIKit.UINavigationController> { .init(identifier: "InitialNavigationController", storyboard: name, bundle: bundle) }
      var mainTabBarController: RswiftResources.StoryboardViewControllerIdentifier<UIKit.UITabBarController> { .init(identifier: "MainTabBarController", storyboard: name, bundle: bundle) }
      var newsDetailViewController: RswiftResources.StoryboardViewControllerIdentifier<NewsDetailViewController> { .init(identifier: "NewsDetailViewController", storyboard: name, bundle: bundle) }

      func validate() throws {
        if UIKit.UIImage(named: "back", in: bundle, compatibleWith: nil) == nil { throw RswiftResources.ValidationError("[R.swift] Image named 'back' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "logo", in: bundle, compatibleWith: nil) == nil { throw RswiftResources.ValidationError("[R.swift] Image named 'logo' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "share", in: bundle, compatibleWith: nil) == nil { throw RswiftResources.ValidationError("[R.swift] Image named 'share' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIColor(named: "detailLabelColor", in: bundle, compatibleWith: nil) == nil { throw RswiftResources.ValidationError("[R.swift] Color named 'detailLabelColor' is used in storyboard 'Main', but couldn't be loaded.") }
        if initialNavigationController() == nil { throw RswiftResources.ValidationError("[R.swift] ViewController with identifier 'initialNavigationController' could not be loaded from storyboard 'Main' as 'UIKit.UINavigationController'.") }
        if mainTabBarController() == nil { throw RswiftResources.ValidationError("[R.swift] ViewController with identifier 'mainTabBarController' could not be loaded from storyboard 'Main' as 'UIKit.UITabBarController'.") }
        if newsDetailViewController() == nil { throw RswiftResources.ValidationError("[R.swift] ViewController with identifier 'newsDetailViewController' could not be loaded from storyboard 'Main' as 'NewsDetailViewController'.") }
      }
    }
  }
}