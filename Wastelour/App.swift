import System.Collections.Generic
import System.Linq
import System.Text

class App {

	var host = Nancy.Hosting.Self.NancyHost(Uri("http://localhost:1234"))

	func run() {
		host.Start()
	}

}
