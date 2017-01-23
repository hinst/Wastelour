import System.Collections.Generic
import System.Linq
import System.Text

class App {

	let host = Nancy.Hosting.Self.NancyHost(Uri("http://localhost:8080"))
	let holder = System.Threading.AutoResetEvent(false)

	func run() {
		host.Start()
		webUI.stopReceiver = receiveStopRequest
		webUI.start()
		holder.WaitOne()
		webUI.stop()
		host.Stop()
	}

	func receiveStopRequest() {
		print("app.stop")
		holder.Set()
	}

}
