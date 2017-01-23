using System.Collections.Generic;
using System.Linq;
using Nancy;

namespace Wastelour
{

	public class TestingModule : NancyModule
	{

		public TestingModule() {
			x = 0;
			Get["/"] = null;
		}

		

	}

}
