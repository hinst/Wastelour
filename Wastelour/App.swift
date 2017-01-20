import System.Collections.Generic
import System.Linq
import System.Text

class App {

	var host = Nancy.Hosting.Self.NancyHost(Uri("http://localhost:8080"))
	var holder = System.Threading.Barrier(0)

	func run() {
		host.Start()
		holder.AddParticipant()
	}

}
