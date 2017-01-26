import System.IO

class App {

	let host = Nancy.Hosting.Self.NancyHost(Uri("http://localhost:8080"))
	let appWebPath = "waste"
	let appDir = Path.GetDirectoryName(System.Reflection.Assembly.GetEntryAssembly().Location)
	public let holder = System.Threading.AutoResetEvent(false)
	public class var global: App? = nil

	init() {
		global = self;
	}

	func run() {
		print(appDir)
		host.Start()
		WebUI.start()
		holder.WaitOne()
		host.Stop()
		WebUI.stop()
	}

	func receiveStopRequest() {
		holder.Set()
	}

}
