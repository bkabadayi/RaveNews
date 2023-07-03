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
  var image: image { .init(bundle: bundle) }
  var file: file { .init(bundle: bundle) }
  var nib: nib { .init(bundle: bundle) }
  var storyboard: storyboard { .init(bundle: bundle) }

  func color(bundle: Foundation.Bundle) -> color {
    .init(bundle: bundle)
  }
  func image(bundle: Foundation.Bundle) -> image {
    .init(bundle: bundle)
  }
  func file(bundle: Foundation.Bundle) -> file {
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

  /// This `_R.color` struct is generated, and contains static references to 2 colors.
  struct color {
    let bundle: Foundation.Bundle

    /// Color `AccentColor`.
    var accentColor: RswiftResources.ColorResource { .init(name: "AccentColor", path: [], bundle: bundle) }

    /// Color `detailLabelColor`.
    var detailLabelColor: RswiftResources.ColorResource { .init(name: "detailLabelColor", path: [], bundle: bundle) }
  }

  /// This `_R.image` struct is generated, and contains static references to 13 images.
  struct image {
    let bundle: Foundation.Bundle

    /// Image `LaunchLogo`.
    var launchLogo: RswiftResources.ImageResource { .init(name: "LaunchLogo", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `back`.
    var back: RswiftResources.ImageResource { .init(name: "back", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `bookmark`.
    var bookmark: RswiftResources.ImageResource { .init(name: "bookmark", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `close`.
    var close: RswiftResources.ImageResource { .init(name: "close", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `country`.
    var country: RswiftResources.ImageResource { .init(name: "country", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `delete`.
    var delete: RswiftResources.ImageResource { .init(name: "delete", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `filter`.
    var filter: RswiftResources.ImageResource { .init(name: "filter", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `language`.
    var language: RswiftResources.ImageResource { .init(name: "language", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `logo`.
    var logo: RswiftResources.ImageResource { .init(name: "logo", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `placeholder`.
    var placeholder: RswiftResources.ImageResource { .init(name: "placeholder", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `search`.
    var search: RswiftResources.ImageResource { .init(name: "search", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `share`.
    var share: RswiftResources.ImageResource { .init(name: "share", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `sources`.
    var sources: RswiftResources.ImageResource { .init(name: "sources", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }
  }

  /// This `_R.file` struct is generated, and contains static references to 1 resource files.
  struct file {
    let bundle: Foundation.Bundle

    /// Resource file `LottieIconTransitions.json`.
    var lottieIconTransitionsJson: RswiftResources.FileResource { .init(name: "LottieIconTransitions", pathExtension: "json", bundle: bundle, locale: LocaleReference.none) }
  }

  /// This `_R.segue` struct is generated, and contains static references to 4 view controllers.
  struct segue {
    let bookmarkViewController = bookmarkViewController()
    let dailyNewsController = dailyNewsController()
    let newsSearchViewController = newsSearchViewController()
    let newsSourceViewController = newsSourceViewController()

    /// This struct is generated for `BookmarkViewController`, and contains static references to 1 segues.
    struct bookmarkViewController {

      /// Segue identifier `bookmarkSourceSegue`.
      var bookmarkSourceSegue: RswiftResources.SegueIdentifier<UIKit.UIStoryboardSegue, BookmarkViewController, NewsDetailViewController> { .init(identifier: "bookmarkSourceSegue") }
    }

    /// This struct is generated for `DailyNewsController`, and contains static references to 2 segues.
    struct dailyNewsController {

      /// Segue identifier `newsDetailSegue`.
      var newsDetailSegue: RswiftResources.SegueIdentifier<UIKit.UIStoryboardSegue, DailyNewsController, NewsDetailViewController> { .init(identifier: "newsDetailSegue") }

      /// Segue identifier `newsSourceSegue`.
      var newsSourceSegue: RswiftResources.SegueIdentifier<UIKit.UIStoryboardSegue, DailyNewsController, UIKit.UINavigationController> { .init(identifier: "newsSourceSegue") }
    }

    /// This struct is generated for `NewsSearchViewController`, and contains static references to 1 segues.
    struct newsSearchViewController {

      /// Segue identifier `newsSearchSegue`.
      var newsSearchSegue: RswiftResources.SegueIdentifier<UIKit.UIStoryboardSegue, NewsSearchViewController, NewsDetailViewController> { .init(identifier: "newsSearchSegue") }
    }

    /// This struct is generated for `NewsSourceViewController`, and contains static references to 1 segues.
    struct newsSourceViewController {

      /// Segue identifier `sourceUnwindSegue`.
      var sourceUnwindSegue: RswiftResources.SegueIdentifier<UIKit.UIStoryboardSegue, NewsSourceViewController, UIKit.UIViewController> { .init(identifier: "sourceUnwindSegue") }
    }
  }

  /// This `_R.nib` struct is generated, and contains static references to 3 nibs.
  struct nib {
    let bundle: Foundation.Bundle

    /// Nib `BookmarkItemsCell`.
    var bookmarkItemsCell: RswiftResources.NibReferenceReuseIdentifier<BookmarkItemsCell, BookmarkItemsCell> { .init(name: "BookmarkItemsCell", bundle: bundle, identifier: "BookmarkItemsCell") }

    /// Nib `DailyNewsItemCell`.
    var dailyNewsItemCell: RswiftResources.NibReferenceReuseIdentifier<DailyNewsItemCell, DailyNewsItemCell> { .init(name: "DailyNewsItemCell", bundle: bundle, identifier: "DailyNewsItemCell") }

    /// Nib `DailySourceItemCell`.
    var dailySourceItemCell: RswiftResources.NibReferenceReuseIdentifier<DailySourceItemCell, DailySourceItemCell> { .init(name: "DailySourceItemCell", bundle: bundle, identifier: "DailySourceItemCell") }

    func validate() throws {
      if UIKit.UIImage(named: "delete", in: bundle, compatibleWith: nil) == nil { throw RswiftResources.ValidationError("[R.swift] Image named 'delete' is used in nib 'BookmarkItemsCell', but couldn't be loaded.") }
    }
  }

  /// This `_R.reuseIdentifier` struct is generated, and contains static references to 5 reuse identifiers.
  struct reuseIdentifier {

    /// Reuse identifier `BookmarkItemsCell`.
    let bookmarkItemsCell: RswiftResources.ReuseIdentifier<BookmarkItemsCell> = .init(identifier: "BookmarkItemsCell")

    /// Reuse identifier `DailyNewsItemCell`.
    let dailyNewsItemCell: RswiftResources.ReuseIdentifier<DailyNewsItemCell> = .init(identifier: "DailyNewsItemCell")

    /// Reuse identifier `DailySourceItemCell`.
    let dailySourceItemCell: RswiftResources.ReuseIdentifier<DailySourceItemCell> = .init(identifier: "DailySourceItemCell")

    /// Reuse identifier `newsFooterView`.
    let newsFooterView: RswiftResources.ReuseIdentifier<UIKit.UICollectionReusableView> = .init(identifier: "newsFooterView")

    /// Reuse identifier `SourceCell`.
    let sourceCell: RswiftResources.ReuseIdentifier<UIKit.UITableViewCell> = .init(identifier: "SourceCell")
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
        if UIKit.UIImage(named: "LaunchLogo", in: bundle, compatibleWith: nil) == nil { throw RswiftResources.ValidationError("[R.swift] Image named 'LaunchLogo' is used in storyboard 'LaunchScreen', but couldn't be loaded.") }
      }
    }

    /// Storyboard `Main`.
    struct main: RswiftResources.StoryboardReference, RswiftResources.InitialControllerContainer {
      typealias InitialController = UIKit.UITabBarController

      let bundle: Foundation.Bundle

      let name = "Main"

      var bookmarkViewController: RswiftResources.StoryboardViewControllerIdentifier<BookmarkViewController> { .init(identifier: "BookmarkViewController", storyboard: name, bundle: bundle) }
      var initialNavigationController: RswiftResources.StoryboardViewControllerIdentifier<UIKit.UINavigationController> { .init(identifier: "InitialNavigationController", storyboard: name, bundle: bundle) }
      var mainTabBarController: RswiftResources.StoryboardViewControllerIdentifier<UIKit.UITabBarController> { .init(identifier: "MainTabBarController", storyboard: name, bundle: bundle) }
      var newsDetailViewController: RswiftResources.StoryboardViewControllerIdentifier<NewsDetailViewController> { .init(identifier: "NewsDetailViewController", storyboard: name, bundle: bundle) }
      var newsSourceViewController: RswiftResources.StoryboardViewControllerIdentifier<NewsSourceViewController> { .init(identifier: "NewsSourceViewController", storyboard: name, bundle: bundle) }
      var sourceNavigationController: RswiftResources.StoryboardViewControllerIdentifier<UIKit.UINavigationController> { .init(identifier: "SourceNavigationController", storyboard: name, bundle: bundle) }

      func validate() throws {
        if UIKit.UIImage(named: "back", in: bundle, compatibleWith: nil) == nil { throw RswiftResources.ValidationError("[R.swift] Image named 'back' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "bookmark", in: bundle, compatibleWith: nil) == nil { throw RswiftResources.ValidationError("[R.swift] Image named 'bookmark' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "country", in: bundle, compatibleWith: nil) == nil { throw RswiftResources.ValidationError("[R.swift] Image named 'country' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "filter", in: bundle, compatibleWith: nil) == nil { throw RswiftResources.ValidationError("[R.swift] Image named 'filter' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "language", in: bundle, compatibleWith: nil) == nil { throw RswiftResources.ValidationError("[R.swift] Image named 'language' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "logo", in: bundle, compatibleWith: nil) == nil { throw RswiftResources.ValidationError("[R.swift] Image named 'logo' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "search", in: bundle, compatibleWith: nil) == nil { throw RswiftResources.ValidationError("[R.swift] Image named 'search' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "share", in: bundle, compatibleWith: nil) == nil { throw RswiftResources.ValidationError("[R.swift] Image named 'share' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIColor(named: "detailLabelColor", in: bundle, compatibleWith: nil) == nil { throw RswiftResources.ValidationError("[R.swift] Color named 'detailLabelColor' is used in storyboard 'Main', but couldn't be loaded.") }
        if bookmarkViewController() == nil { throw RswiftResources.ValidationError("[R.swift] ViewController with identifier 'bookmarkViewController' could not be loaded from storyboard 'Main' as 'BookmarkViewController'.") }
        if initialNavigationController() == nil { throw RswiftResources.ValidationError("[R.swift] ViewController with identifier 'initialNavigationController' could not be loaded from storyboard 'Main' as 'UIKit.UINavigationController'.") }
        if mainTabBarController() == nil { throw RswiftResources.ValidationError("[R.swift] ViewController with identifier 'mainTabBarController' could not be loaded from storyboard 'Main' as 'UIKit.UITabBarController'.") }
        if newsDetailViewController() == nil { throw RswiftResources.ValidationError("[R.swift] ViewController with identifier 'newsDetailViewController' could not be loaded from storyboard 'Main' as 'NewsDetailViewController'.") }
        if newsSourceViewController() == nil { throw RswiftResources.ValidationError("[R.swift] ViewController with identifier 'newsSourceViewController' could not be loaded from storyboard 'Main' as 'NewsSourceViewController'.") }
        if sourceNavigationController() == nil { throw RswiftResources.ValidationError("[R.swift] ViewController with identifier 'sourceNavigationController' could not be loaded from storyboard 'Main' as 'UIKit.UINavigationController'.") }
      }
    }
  }
}