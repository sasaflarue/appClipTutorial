/// Copyright (c) 2022 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI
import CoreLocation

@main
struct SwiftyLemonadeClipApp: App {
  
  @StateObject private var model = SwiftyLemonadeClipModel()
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(model)
        .onContinueUserActivity(
                NSUserActivityTypeBrowsingWeb,
                perform: handleUserActivity)
    }
  }
  
  private func handleUserActivity(_ userActivity: NSUserActivity) {
    guard
      let incomingURL = userActivity.webpageURL,
      let components = URLComponents(
        url: incomingURL,
        resolvingAgainstBaseURL: true),
      let queryItems = components.queryItems
    else {
      return
    }

    guard
      let latValue = queryItems.first(where: { $0.name == "lat" })?.value,
      let lonValue = queryItems.first(where: { $0.name == "lon" })?.value,
      let lat = Double(latValue),
      let lon = Double(lonValue)
    else {
      return
    }

    let location = CLLocationCoordinate2D(
      latitude: CLLocationDegrees(lat),
      longitude: CLLocationDegrees(lon))

    if let stand = standData.first(where: { $0.coordinate == location }) {
      model.selectedStand = stand
      print("Welcome to \(stand.title)! :]")
    } else {
      model.locationFound = false
    }
  }
}
