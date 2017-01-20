import System.Dynamic
import Nancy

public class WebUI : NancyModule {

	init() {
		let testFunction: (Any) -> Any = test
		self.Get["/test"] = testFunction
	}

	func test(a: Any) -> Any {
		Console.WriteLine(a.GetType())
		return "Test."
	}

	func stop(a: Object) -> Object {
		return ""
	}

}
