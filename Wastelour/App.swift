import System.Collections.Generic
import System.Linq
import System.Text

class App {

	var host = Nancy.Hosting.Self.NancyHost(Uri("http://localhost:8080"))
	var holder = System.Threading.Barrier(0)
	var webUI = WebUI()

	func run() {
		host.Start()
		webUI.start()
		webUI.stop()
	}

}
