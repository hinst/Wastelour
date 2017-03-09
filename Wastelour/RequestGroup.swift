import System.Collections.Generic
import System.Linq
import System.Text
import System.Threading

class RequestGroup {

	var count = 0
	var removingEvent = AutoResetEvent(false)
	var mutex = Mutex()
	
	func add() {
		mutex.WaitOne()
		count += 1
		mutex.ReleaseMutex()
	}

	func remove() {
		mutex.WaitOne()
		count -= 1
		mutex.ReleaseMutex()
		removingEvent.Set()
	}

	func wait() {
		var waitingInterval = TimeSpan(0, 0, 1)
		while (true) {
			mutex.WaitOne()
			if count <= 0 {
				break
			}
			mutex.ReleaseMutex()
			removingEvent.WaitOne(waitingInterval)
		}
	}

}
