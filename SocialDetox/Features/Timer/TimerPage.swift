import SwiftUI

struct TimerPage: View {
  @Environment(\.displayScale) var displayScale
  @StateObject var pip = PiP()
  @StateObject var deadline = Deadline()
  @Clock var clock
  @State var remainingTime: Int

  init(hour: Int, minute: Int) {
    remainingTime = .remainingTime(hour: hour, minute: minute)
  }

  var body: some View {
    let countdown = Countdown(remainingTime: remainingTime)

    VStack {
      if pip.canStart {
        PiPContainer()
          .onChange(of: clock.now) { _ in
            switch pip.progress {
            case .willStart, .didStart:
              if remainingTime > 0 {
                self.remainingTime = remainingTime - 1
              }
            case nil, .willStop, .didStop:
              break
            }

            pip.enqueue(content: countdown, displayScale: displayScale)
          }
          .onChange(of: remainingTime, perform: { remainingTime in
            guard remainingTime <= 0 else {
              return
            }
            print(remainingTime)
          })
          .frame(width: pip.size.width, height: pip.size.height)

        if pip.isActivated {
          Button {
            pip.stop()
          } label: {
            Image(systemName: "stop.fill")
              .imageScale(.large)
              .foregroundColor(.accentColor)
          }
        } else {
          Button {
            pip.start()
          } label: {
            Image(systemName: "play.fill")
              .imageScale(.large)
              .foregroundColor(.accentColor)
          }
        }
      } else {
        ProgressView()
      }
    }
  }
}

struct TimerPage_Previews: PreviewProvider {
  static var previews: some View {
    TimerPage(hour: 0, minute: 30)
  }
}


