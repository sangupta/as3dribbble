/**
 *
 * as3dribbble: ActionScript Client for Dribbble.com API
 * Copyright (C) 2012, Sandeep Gupta
 * 
 * http://www.sangupta.com/projects/as3dribbble
 *
 * The file is licensed under the the Apache License, Version 2.0
 * (the "License"); you may not use this work except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

package com.sangupta.dribbble.api {
	
	/**
	 * Holds function callbacks between multiple calls.
	 * 
	 * @author sangupta
	 */
	public class DribbbleFunctionCallback {

		public var dribbbleCompletionHandler:Function = null;
		
		public var dribbbleErrorHandler:Function = null;
		
		public var parseFunction:Function = null;
		
		public function destroy():void {
			this.dribbbleCompletionHandler = null;
			this.dribbbleErrorHandler = null;
			this.parseFunction = null;
		}
		
	}
}
