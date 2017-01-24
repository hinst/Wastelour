import System.Collections.Generic
import System.Linq
import System.Text

class App {

	let host = Nancy.Hosting.Self.NancyHost(Uri("http://localhost:8080"))
	public let holder = System.Threading.AutoResetEvent(false)
	public class var global: App? = nil

	init() {
		global = self;
	}

	func run() {
		host.Start()
		WebUI.start()
		holder.WaitOne()
		host.Stop()
		WebUI.stop()
	}

	func receiveStopRequest() {
		print("app.stop")
		holder.Set()
	}

}
