
import Foundation

class SwiftyLemonadeClipModel: ObservableObject {
  @Published var selectedStand: LemonadeStand?
  @Published var locationFound = true
}
