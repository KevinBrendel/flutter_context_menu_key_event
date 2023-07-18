import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)
      
      let debugChannel = FlutterMethodChannel(
            name: "debug/channel",
            binaryMessenger: flutterViewController.engine.binaryMessenger)
      debugChannel.setMethodCallHandler { (call, result) in
              switch (call.method) {
              case "openMenu":
                  let args = call.arguments as! NSDictionary
                  let x = args["x"] as! Double
                  let y = args["y"] as! Double
                  let menu = NSMenu()
                  menu.items = [
                    NSMenuItem(title: "Item 1", action: #selector(self.doNothing), keyEquivalent: "1"),
                    NSMenuItem(title: "Item 2", action: #selector(self.doNothing), keyEquivalent: "2"),
                    NSMenuItem(title: "Item 3", action: #selector(self.doNothing), keyEquivalent: "3"),
                  ]
                  let didSelect = menu.popUp(positioning: nil, at: NSPoint(x: x, y: y), in: self.contentView)
              if (didSelect) {
                  result(menu.highlightedItem?.title)
              } else {
                result(nil)
              }
              default:
                  result(FlutterMethodNotImplemented)
              }
          }

    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }
    
@objc func doNothing() {}
}
